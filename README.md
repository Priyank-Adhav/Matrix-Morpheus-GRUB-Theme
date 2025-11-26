# Matrix Morpheus GRUB Theme (Ubuntu Version)
**Red Pill vs Blue Pill**

Tema minimalista inspirado en Matrix para GRUB con fondos dinámicos a pantalla completa que cambian entre Linux y Windows.

Fork modificado del [tema original de Priyank-Adhav](https://github.com/Priyank-Adhav/Matrix-Morpheus-GRUB-Theme), adaptado para **Ubuntu + Windows** dual-boot.

---

**Características de esta versión:**
- Detección automática de distribución Linux
- Configuración automática de resolución 1920x1080
- Simplificación del menú GRUB (solo Ubuntu y Windows)
- Deshabilitación automática de entradas extra (memtest, recovery, etc.)

Los iconos están ordenados horizontalmente en pantalla,  
pero se navega usando las teclas **Arriba** y **Abajo** como en un menú GRUB normal.

---

![Matrix Morpheus GRUB Theme preview](preview.gif)

## Instalación

1. Clona el repositorio

```shell
git clone https://github.com/rflvz/Matrix-Morpheus-GRUB-Theme-ubuntu-version
```

2. Entra en la carpeta

```shell
cd Matrix-Morpheus-GRUB-Theme-ubuntu-version
```

3. Haz el instalador ejecutable

```shell
chmod +x install.sh
```

4. Ejecuta el script de instalación como administrador

```shell
sudo ./install.sh
```

5. Reinicia para ver tu nuevo tema

---

## Notas

- El script crea automáticamente los iconos necesarios para Ubuntu (`ubuntu.png`, `gnu-linux.png`, `linux.png`) a partir de la imagen base.
- Windows usa `windows.png` que ya viene incluido.
- El script deshabilita automáticamente las entradas extra de GRUB para dejar solo Ubuntu y Windows.
- Si tienes varios kernels instalados, considera eliminar los antiguos con `sudo apt autoremove`.

## Créditos

Tema original por [Priyank-Adhav](https://github.com/Priyank-Adhav/Matrix-Morpheus-GRUB-Theme)
