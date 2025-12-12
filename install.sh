#!/bin/bash

# Script de instalación para Hyprland Rice
# Copia configuraciones y da permisos a scripts necesarios

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_message() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

# Verificar que no se ejecute como root
if [ "$EUID" -eq 0 ]; then 
    print_error "No ejecutes este script como root"
    exit 1
fi

# Obtener directorio del script (donde está el repo)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SOURCE="$SCRIPT_DIR/.config"
CONFIG_DEST="$HOME/.config"

echo -e "${BLUE}╔═══════════════════════════════════════╗${NC}"
echo -e "${BLUE}║${NC}   Instalador de Hyprland Rice       ${BLUE}║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════╝${NC}"
echo ""

# Verificar que existe el directorio .config en el repo
if [ ! -d "$CONFIG_SOURCE" ]; then
    print_error "No se encontró el directorio .config en el repositorio"
    print_error "Ruta esperada: $CONFIG_SOURCE"
    exit 1
fi

print_message "Directorio del repo: $SCRIPT_DIR"
print_message "Configuraciones origen: $CONFIG_SOURCE"
print_message "Destino: $CONFIG_DEST"
echo ""

# Preguntar si hacer backup
read -p "¿Deseas hacer backup de tu configuración actual? (s/n): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Ss]$ ]]; then
    BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
    print_message "Creando backup en: $BACKUP_DIR"
    
    mkdir -p "$BACKUP_DIR"
    
    # Backup solo de los directorios que vamos a sobrescribir
    for item in "$CONFIG_SOURCE"/*; do
        item_name=$(basename "$item")
        if [ -e "$CONFIG_DEST/$item_name" ]; then
            cp -r "$CONFIG_DEST/$item_name" "$BACKUP_DIR/"
            print_success "Backup: $item_name"
        fi
    done
    
    print_success "Backup completado"
    echo ""
fi

# Crear directorio .config si no existe
mkdir -p "$CONFIG_DEST"

# Copiar todas las configuraciones
print_message "Copiando configuraciones..."
echo ""

for item in "$CONFIG_SOURCE"/*; do
    item_name=$(basename "$item")
    print_message "Copiando $item_name..."
    cp -r "$item" "$CONFIG_DEST/"
    
    if [ $? -eq 0 ]; then
        print_success "$item_name copiado"
    else
        print_error "Error al copiar $item_name"
    fi
done

echo ""
print_message "Configurando permisos de scripts..."

# Dar permisos a los scripts específicos
SCRIPTS=(
    "$CONFIG_DEST/hypr/scripts/wallpaper-picker.sh"
    "$CONFIG_DEST/rofi/scripts/powermenu.sh"
)

for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        chmod +x "$script"
        print_success "Permisos otorgados: $script"
    else
        print_warning "No se encontró: $script"
    fi
done

# Dar permisos a todos los scripts en los directorios por si acaso
print_message "Dando permisos a todos los scripts .sh encontrados..."
find "$CONFIG_DEST/hypr/scripts" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null
find "$CONFIG_DEST/rofi/scripts" -type f -name "*.sh" -exec chmod +x {} \; 2>/dev/null

echo ""
print_success "¡Instalación completada!"
echo ""
print_warning "Recuerda:"
echo "  - Reinicia Hyprland para aplicar los cambios (Super+Shift+E o reloguea)"
echo "  - Verifica que tienes instalados todos los paquetes necesarios"
echo ""
