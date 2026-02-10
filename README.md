
<div align="right">
  <details>
    <summary >🌐 Language</summary>
    <div>
      <div align="center">
        <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=en">English</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=zh-CN">简体中文</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=zh-TW">繁體中文</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=ja">日本語</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=ko">한국어</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=hi">हिन्दी</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=th">ไทย</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=fr">Français</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=de">Deutsch</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=es">Español</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=it">Italiano</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=ru">Русский</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=pt">Português</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=nl">Nederlands</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=pl">Polski</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=ar">العربية</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=fa">فارسی</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=tr">Türkçe</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=vi">Tiếng Việt</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=id">Bahasa Indonesia</a>
        | <a href="https://openaitx.github.io/view.html?user=Priyank-Adhav&project=Matrix-Morpheus-GRUB-Theme&lang=as">অসমীয়া</
      </div>
    </div>
  </details>
</div>

# Matrix Morpheus GRUB Theme
**Red Pill vs Blue Pill**

A minimalist Matrix-inspired GRUB theme featuring full-screen dynamic backgrounds that change between Linux and Windows.

---

**Note:**  
Currently, the theme only includes the **Arch Linux** and **Windows** icons.  
 
Also, while the icons are **arranged horizontally** on screen,  
you still navigate using the **Up** and **Down arrow keys** as in a normal GRUB menu.

---
![Matrix Morpheus GRUB Theme preview showing Arch and Windows boot icons](preview.gif)
## Installation

1. Clone the repo

```shell
git clone https://github.com/Priyank-Adhav/Matrix-Morpheus-GRUB-Theme
```

2. Go into the folder 

```shell
cd Matrix-Morpheus-GRUB-Theme
```

3. Make the installer executable

```shell
chmod +x install.sh
```

4. Execute the installation script as admin

```shell
sudo ./install.sh
```

5. Reboot to test your new theme

---
Optional: Simplify Your GRUB Menu

I designed this theme for a two entry layout and haven't really thought about how to visually handle the additional entries. 

If your GRUB menu currently has extra entries such as:

- “Advanced options for Arch Linux”
- “UEFI Firmware Settings”

I would recommend you remove the extra menu entries from the grub config if you don't use them.