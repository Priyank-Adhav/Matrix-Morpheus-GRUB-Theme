#!/bin/bash
# ===============================================================
# Matrix Morpheus GRUB Theme Installer
# Repository: https://github.com/Priyank-Adhav/Matrix-GRUB-Theme
# ===============================================================

set -e

THEME_NAME="Matrix"
THEME_DIR="/boot/grub/themes"
GRUB_CFG="/etc/default/grub"
GRUB_FILE="/boot/grub/grub.cfg"

echo ""
echo "==========================="
echo "Matrix GRUB Theme Installer"
echo "==========================="
echo ""

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (use sudo)."
    exit 1
fi

# Detect resolution
echo "Detecting screen resolution..."
RES=""

# 1. Try GRUB_GFXMODE if it's not "auto"
if grep -q '^GRUB_GFXMODE=' "$GRUB_CFG"; then
    POTENTIAL_RES=$(grep '^GRUB_GFXMODE=' "$GRUB_CFG" | cut -d'=' -f2 | tr -d '"' | tr -d "'")
    if [ "$POTENTIAL_RES" != "auto" ] && [ -n "$POTENTIAL_RES" ]; then
        RES="$POTENTIAL_RES"
    fi
fi

# 2. Try /sys/class/drm if RES is still empty
if [ -z "$RES" ] && [ -d /sys/class/drm ]; then
    RES=$(cat /sys/class/drm/*/modes 2>/dev/null | head -n 1)
fi

# 3. Try xrandr if RES is still empty (for X11 sessions)
if [ -z "$RES" ] && command -v xrandr >/dev/null 2>&1; then
    RES=$(xrandr | grep '*' | head -n 1 | awk '{print $1}' | cut -d'x' -f1,2)
fi

if [ -z "$RES" ] || [ "$RES" == "auto" ]; then
    echo "Could not detect numeric resolution, defaulting to 1366x768"
    RES="1366x768" # setting this as a default bcos the end user might use a laptop , hehe
else
    echo "Detected resolution: $RES"
fi

WIDTH=$(echo $RES | cut -d'x' -f1)
HEIGHT=$(echo $RES | cut -d'x' -f2)

# Ensure theme directory exists
echo "Checking for theme directory..."
mkdir -p "$THEME_DIR"

# Copy theme files
echo "Installing theme..."
cp -r "$THEME_NAME" "$THEME_DIR/" || {
    echo "Failed to copy theme files."
    exit 1
}

# Update resolution in theme.txt
THEME_FILE="${THEME_DIR}/${THEME_NAME}/theme.txt"
echo "Adjusting theme for resolution ${WIDTH}x${HEIGHT}..."
sed -i "s/^    icon_width = .*/    icon_width = $WIDTH/" "$THEME_FILE"
sed -i "s/^    icon_height = .*/    icon_height = $HEIGHT/" "$THEME_FILE"
sed -i "s/^    item_height = .*/    item_height = $HEIGHT/" "$THEME_FILE"

# Configure GRUB to use the new theme and resolution
echo "Updating GRUB configuration..."

# Update GRUB_GFXMODE
if grep -q '^GRUB_GFXMODE=' "$GRUB_CFG"; then
    sed -i "s|^GRUB_GFXMODE=.*|GRUB_GFXMODE=\"${RES}\"|" "$GRUB_CFG"
else
    echo "GRUB_GFXMODE=\"${RES}\"" >>"$GRUB_CFG"
fi

# Update GRUB_THEME
if grep -q '^GRUB_THEME=' "$GRUB_CFG"; then
    sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"|" "$GRUB_CFG"
else
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >>"$GRUB_CFG"
fi

# Regenerate GRUB
echo "Rebuilding GRUB configuration..."
if command -v grub-mkconfig >/dev/null 2>&1; then
    grub-mkconfig -o "$GRUB_FILE" >/dev/null
    echo "GRUB configuration updated successfully."
else
    echo "grub-mkconfig not found. Please update your GRUB manually."
    exit 1
fi

echo ""
echo "Installation complete!"
echo "Reboot to see your new Matrix GRUB theme."
echo ""
