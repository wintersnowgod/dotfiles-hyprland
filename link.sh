#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'  # No color (reset to default)

# Get absolute path of the script’s directory (resolves symlinks too)
script_dir="$(cd "$(dirname "$(readlink -f "$0")")" && pwd)"

# Dotfiles source directory
DOTFILES_DIR="$script_dir"

# Central backup directory
BACKUP_DIR="$HOME/dotfiles/backup"

# Config files/folders to link into ~/.config
config_files=(
    "gtk-3.0"
    "gtk-4.0"
    "hypr"
    "kitty"
    "nwg-look"
    "qt5ct"
    "qt6ct"
    "swaync"
    "waybar"
    "wlogout"
    "wofi"
    "xsettingsd"
    "kdeglobals"
    "mimeapps.list"
)

# Files/folders to link into ~/.local/share
localshare=(
    "icons/breeze_cursors"
    "themes"
)

link_config() {
    src="$1"
    dest="$2"
    relpath="${dest/#$HOME\//}"   # e.g. .config/gtk-3.0
    backup="$BACKUP_DIR/$relpath"

    # If destination exists (file, dir, or symlink)
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mkdir -p "$BACKUP_DIR"
        counter=1
        bak="$backup"
        # Find a free backup name
        while [ -e "$bak" ] || [ -L "$bak" ]; do
            bak="${backup}.${counter}"
            counter=$((counter + 1))
        done

        mkdir -p "$(dirname "$bak")"
        echo -e "${YELLOW}Backing up existing $dest -> $bak${NC}"
        mv "$dest" "$bak"
    fi

    # Ensure parent directory exists
    mkdir -p "$(dirname "$dest")"

    # Create/update symlink
    ln -sfn "$src" "$dest"
    echo -e "${GREEN}Linked $dest -> $src${NC}"
}

# Link ~/.config items
for item in "${config_files[@]}"; do
    link_config "$DOTFILES_DIR/.config/$item" "$HOME/.config/$item"
done

# Link ~/.local/share items
for item in "${localshare[@]}"; do
    link_config "$DOTFILES_DIR/.local/share/$item" "$HOME/.local/share/$item"
done
