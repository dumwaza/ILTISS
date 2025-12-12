#!/usr/bin/env bash

# ==============================
# ILTISS Installer Script
# I like that it's so simple
# ==============================

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ILTISS_DIR="$(pwd)"
HOME_DIR="$HOME"
CONFIG_DIR="$HOME_DIR/.config"

log() {
  echo -e "${GREEN}[ILTISS]${NC} $1"
}

warn() {
  echo -e "${YELLOW}[ILTISS]${NC} $1"
}

error() {
  echo -e "${RED}[ILTISS]${NC} $1"
  exit 1
}

# ------------------------------
# Checks
# ------------------------------

if [[ ! -d "$ILTISS_DIR/.config" ]]; then
  error "No se encontró el directorio .config en el repositorio. Ejecuta el script desde la carpeta raíz de ILTISS."
fi

log "Iniciando instalación de ILTISS"

# ------------------------------
# Backup existing files
# ------------------------------

BACKUP_DIR="$HOME_DIR/.iltiss-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

backup_if_exists() {
  if [[ -e "$1" ]]; then
    warn "Respaldando $1"
    mv "$1" "$BACKUP_DIR/"
  fi
}

backup_if_exists "$CONFIG_DIR"
backup_if_exists "$HOME_DIR/.zshrc"
backup_if_exists "$HOME_DIR/.p10k.zsh"

# ------------------------------
# Install .config
# ------------------------------

log "Instalando configuraciones en ~/.config"
mkdir -p "$CONFIG_DIR"
cp -r "$ILTISS_DIR/.config"/* "$CONFIG_DIR/"

# ------------------------------
# Install Zsh files
# ------------------------------

if [[ -f "$ILTISS_DIR/.zshrc" ]]; then
  log "Instalando .zshrc"
  cp "$ILTISS_DIR/.zshrc" "$HOME_DIR/.zshrc"
fi

if [[ -f "$ILTISS_DIR/.p10k.zsh" ]]; then
  log "Instalando .p10k.zsh"
  cp "$ILTISS_DIR/.p10k.zsh" "$HOME_DIR/.p10k.zsh"
fi

# ------------------------------
# Permissions
# ------------------------------

log "Asignando permisos a scripts"

HYPER_SCRIPT="$CONFIG_DIR/hypr/scripts/wallpaper-picker.sh"
ROFI_SCRIPT="$CONFIG_DIR/rofi/scripts/powermenu.sh"

if [[ -f "$HYPER_SCRIPT" ]]; then
  chmod +x "$HYPER_SCRIPT"
else
  warn "No se encontró $HYPER_SCRIPT"
fi

if [[ -f "$ROFI_SCRIPT" ]]; then
  chmod +x "$ROFI_SCRIPT"
else
  warn "No se encontró $ROFI_SCRIPT"
fi

# ------------------------------
# Done
# ------------------------------

log "Instalación completada"
log "Se creó un respaldo en: $BACKUP_DIR"
log "Reinicia Hyprland o cierra sesión para aplicar todos los cambios"
