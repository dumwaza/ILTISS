# ILTISS

**I Like That It's So Simple**

ILTISS es una configuración para **Hyprland** enfocada totalmente en la simplicidad, la comodidad y la eficiencia.

No busca ser un rice lleno de efectos ni animaciones innecesarias, sino un entorno limpio, funcional y fácil de usar, alineado con la filosofía **KISS** y el espíritu de Arch Linux.

---

## Filosofía

- Minimalismo real
- Sin distracciones
- Fácil de entender y modificar
- Enfocado en el uso diario
- Estética sobria y funcional

---

## Requisitos

ILTISS está pensado para **Arch Linux**.

### Dependencias principales

```bash
sudo pacman -S --needed git base-devel
sudo pacman -S waybar rofi git \
  libappindicator-gtk3 libdbusmenu-gtk3 \
  swww imagemagick swaync pavucontrol hyprlock
```

### Fuentes

```bash
sudo pacman -S noto-fonts-emoji
sudo pacman -S ttf-nerd-fonts-symbols-mono
sudo pacman -S ttf-jetbrains-mono-nerd
```

También es necesario tener instalado:
- Hyprland

---

## Instalación

```bash
git clone https://github.com/dumwaza/ILTISS.git
cd ILTISS
chmod +x install.sh
./install.sh
```

El script:
- Copia los archivos de `.config` a `~/.config`
- Coloca `.zshrc` y `.p10k.zsh` en `$HOME`
- Da permisos de ejecución a los scripts necesarios
- Crea un respaldo automático de archivos existentes

---

## Backup

Antes de sobrescribir cualquier archivo, ILTISS crea un respaldo en:

```bash
~/.iltiss-backup-YYYYMMDD-HHMMSS
```

---

## Notas

- Se recomienda cerrar sesión o reiniciar Hyprland después de la instalación
- ILTISS está pensado para usarse tal como viene, pero es totalmente modificable

---

## Licencia

Proyecto personal / uso libre
