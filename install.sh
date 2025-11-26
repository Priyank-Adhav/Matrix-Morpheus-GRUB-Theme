#!/bin/bash
# ===============================================================
# Matrix Morpheus GRUB Theme Installer
# Para Ubuntu + Windows dual-boot
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
    echo "Por favor ejecuta este script como root (usa sudo)."
    exit 1
fi

# Ensure theme directory exists 
echo "Verificando directorio de temas..."
mkdir -p "$THEME_DIR"

# Copy theme files 
echo "Instalando tema..."
cp -r "$THEME_NAME" "$THEME_DIR/" || {
    echo "Error al copiar archivos del tema."
    exit 1
}

# Detectar distribución Linux
echo "Detectando distribución Linux..."
DISTRO=""
if [ -f /etc/os-release ]; then
    DISTRO=$(grep "^ID=" /etc/os-release | cut -d'=' -f2 | tr -d '"')
fi

echo "Distribución detectada: $DISTRO"

# Crear iconos para la distribución detectada
ICONS_DIR="$THEME_DIR/$THEME_NAME/icons"

if [ -f "$ICONS_DIR/arch.png" ]; then
    # Crear icono para la distribución detectada
    if [ -n "$DISTRO" ]; then
        cp "$ICONS_DIR/arch.png" "$ICONS_DIR/${DISTRO}.png"
        echo "Icono creado: ${DISTRO}.png"
    fi
    # También crear iconos genéricos por si acaso
    cp "$ICONS_DIR/arch.png" "$ICONS_DIR/gnu-linux.png"
    cp "$ICONS_DIR/arch.png" "$ICONS_DIR/linux.png"
    echo "Iconos de Linux configurados."
fi

# Configurar GRUB_THEME
echo "Actualizando configuración de GRUB..."
if grep -q '^GRUB_THEME=' "$GRUB_CFG"; then
    sed -i "s|^GRUB_THEME=.*|GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"|" "$GRUB_CFG"
elif grep -q '^#GRUB_THEME=' "$GRUB_CFG"; then
    sed -i "s|^#GRUB_THEME=.*|GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"|" "$GRUB_CFG"
else
    echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> "$GRUB_CFG"
fi

# Configurar GRUB_GFXMODE para 1920x1080 (necesario para el tema)
echo "Configurando resolución gráfica..."
if grep -q '^GRUB_GFXMODE=' "$GRUB_CFG"; then
    sed -i 's|^GRUB_GFXMODE=.*|GRUB_GFXMODE=1920x1080|' "$GRUB_CFG"
elif grep -q '^#GRUB_GFXMODE=' "$GRUB_CFG"; then
    sed -i 's|^#GRUB_GFXMODE=.*|GRUB_GFXMODE=1920x1080|' "$GRUB_CFG"
else
    echo "GRUB_GFXMODE=1920x1080" >> "$GRUB_CFG"
fi

# Asegurar que GRUB_TERMINAL_OUTPUT no esté en modo console
if grep -q '^GRUB_TERMINAL_OUTPUT=console' "$GRUB_CFG"; then
    sed -i 's|^GRUB_TERMINAL_OUTPUT=console|#GRUB_TERMINAL_OUTPUT=console|' "$GRUB_CFG"
fi
if grep -q '^GRUB_TERMINAL=console' "$GRUB_CFG"; then
    sed -i 's|^GRUB_TERMINAL=console|#GRUB_TERMINAL=console|' "$GRUB_CFG"
fi

# Habilitar os-prober para detectar Windows
echo "Habilitando detección de Windows..."
if grep -q '^#GRUB_DISABLE_OS_PROBER=false' "$GRUB_CFG"; then
    sed -i 's|^#GRUB_DISABLE_OS_PROBER=false|GRUB_DISABLE_OS_PROBER=false|' "$GRUB_CFG"
elif ! grep -q '^GRUB_DISABLE_OS_PROBER=false' "$GRUB_CFG"; then
    echo "GRUB_DISABLE_OS_PROBER=false" >> "$GRUB_CFG"
fi

# Ocultar submenús (Advanced options for Ubuntu)
echo "Simplificando menú GRUB (ocultando entradas extra)..."
if grep -q '^#GRUB_DISABLE_SUBMENU=' "$GRUB_CFG"; then
    sed -i 's|^#GRUB_DISABLE_SUBMENU=.*|GRUB_DISABLE_SUBMENU=y|' "$GRUB_CFG"
elif ! grep -q '^GRUB_DISABLE_SUBMENU=' "$GRUB_CFG"; then
    echo "GRUB_DISABLE_SUBMENU=y" >> "$GRUB_CFG"
fi

# Ocultar opciones de recovery
if grep -q '^#GRUB_DISABLE_RECOVERY=' "$GRUB_CFG"; then
    sed -i 's|^#GRUB_DISABLE_RECOVERY=.*|GRUB_DISABLE_RECOVERY=true|' "$GRUB_CFG"
elif ! grep -q '^GRUB_DISABLE_RECOVERY=' "$GRUB_CFG"; then
    echo "GRUB_DISABLE_RECOVERY=true" >> "$GRUB_CFG"
fi

# Deshabilitar TODOS los scripts innecesarios de grub.d
echo "Deshabilitando entradas extra de GRUB..."

# Memtest86+
if [ -x /etc/grub.d/20_memtest86+ ]; then
    chmod -x /etc/grub.d/20_memtest86+
    echo "  - Memtest86+ deshabilitado"
fi

# UEFI Firmware Settings
if [ -x /etc/grub.d/30_uefi-firmware ]; then
    chmod -x /etc/grub.d/30_uefi-firmware
    echo "  - UEFI Firmware deshabilitado"
fi

# Linux ZFS (si no usas ZFS)
if [ -x /etc/grub.d/10_linux_zfs ]; then
    chmod -x /etc/grub.d/10_linux_zfs
    echo "  - Linux ZFS deshabilitado"
fi

# Linux Xen
if [ -x /etc/grub.d/20_linux_xen ]; then
    chmod -x /etc/grub.d/20_linux_xen
    echo "  - Linux Xen deshabilitado"
fi

# BLI
if [ -x /etc/grub.d/25_bli ]; then
    chmod -x /etc/grub.d/25_bli
    echo "  - BLI deshabilitado"
fi

# Firmware update
if [ -x /etc/grub.d/35_fwupd ]; then
    chmod -x /etc/grub.d/35_fwupd
    echo "  - Fwupd deshabilitado"
fi

# Limpiar kernels antiguos - mantener solo el actual
echo "Configurando para mostrar solo el kernel actual..."
CURRENT_KERNEL=$(uname -r)
echo "Kernel actual: $CURRENT_KERNEL"

# Regenerate GRUB
echo "Regenerando configuración de GRUB..."
if command -v update-grub >/dev/null 2>&1; then
    update-grub
elif command -v grub-mkconfig >/dev/null 2>&1; then
    grub-mkconfig -o "$GRUB_FILE"
else
    echo "No se encontró update-grub ni grub-mkconfig."
    exit 1
fi

echo ""
echo "¡Instalación completada!"
echo "Reinicia para ver tu nuevo tema Matrix de GRUB."
echo ""
