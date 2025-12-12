# ILTISS - I Like That It's So Simple

Una configuracion minimalista para Hyprland enfocada en la simplicidad y funcionalidad.

================================================================================
DESCRIPCION
================================================================================

ILTISS es un rice limpio y eficiente para Hyprland que prioriza la simplicidad 
sin sacrificar las caracteristicas esenciales. Perfecto para quienes buscan un 
entorno de escritorio funcional y visualmente agradable sin complicaciones 
innecesarias.

================================================================================
REQUISITOS E INSTALACION DE DEPENDENCIAS
================================================================================

Ejecuta los siguientes comandos en orden:

# Instalar Waybar
sudo pacman -S waybar

# Fuentes necesarias
sudo pacman -S ttf-nerd-fonts-symbols-mono
sudo pacman -S ttf-jetbrains-mono-nerd

# Instalar yay (AUR helper)
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Herramientas esenciales
sudo pacman -S rofi
sudo pacman -S zsh
sudo pacman -S fastfetch
sudo pacman -S git

# Tema para zsh
yay -S zsh-theme-powerlevel10k-git

# Dependencias del sistema
sudo pacman -S libappindicator-gtk3 libdbusmenu-gtk3

# Gestion de wallpapers y efectos
sudo pacman -S swww
sudo pacman -S imagemagick

# Notificaciones y audio
sudo pacman -S swaync
sudo pacman -S pavucontrol

# Bloqueo de pantalla
sudo pacman -S hyprlock

================================================================================
INSTALACION
================================================================================

1. Clona este repositorio:
   git clone https://github.com/tu-usuario/ILTISS.git
   cd ILTISS

2. Copia los archivos de configuracion a tu directorio .config:
   cp -r .config/* ~/.config/

3. IMPORTANTE: Crea el directorio para wallpapers:
   mkdir -p ~/.config/wallpapers

4. Coloca tus wallpapers en ~/.config/wallpapers para que el wallpaper picker 
   pueda encontrarlos.

================================================================================
ATAJOS DE TECLADO
================================================================================

SUPER + T  ->  Abrir terminal
SUPER + R  ->  Lanzador de aplicaciones (Rofi)
SUPER + W  ->  Selector de wallpapers
SUPER + L  ->  Menu de energia

================================================================================
NOTAS IMPORTANTES
================================================================================

- Asegurate de guardar todos tus wallpapers en ~/.config/wallpapers para que 
  el selector funcione correctamente.

- Si deseas personalizar los atajos de teclado, edita el archivo de 
  configuracion de Hyprland en ~/.config/hypr/hyprland.conf.

================================================================================
CONTRIBUCIONES
================================================================================

Las contribuciones son bienvenidas. Si encuentras algun problema o tienes 
sugerencias, no dudes en abrir un issue o pull request.

================================================================================
LICENCIA
================================================================================

Este proyecto es de codigo abierto y esta disponible bajo la licencia MIT.

================================================================================

ILTISS - Porque a veces, menos es mas.
