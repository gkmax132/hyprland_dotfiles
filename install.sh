#!/bin/bash

BACKUPS_DIR="$HOME/backups"
CONFIG_DIR="$(dirname "$0")/configs"
CONFIG_TARGET_DIR="$HOME/.config"

# Function to display help message
show_help() {
    echo "Usage: ./install.sh [OPTION]"
    echo "Manage configuration files for your system."
    echo
    echo "Options:"
    echo "  -i    Install configuration files from configs/ to ~/.config/"
    echo "  -r    Restore configuration files from backups/ to ~/.config/"
    echo "  -b    Backup existing configuration files to backups/"
    echo "  -h    Show this help message"
    echo
    echo "Run with no options to see this message."
    exit 0
}

# Default values
restore=false
install=false
backup=false

# Check for flags
while getopts ":ribh" opt; do
    case ${opt} in
        r ) restore=true ;;      # Restore backup
        i ) install=true ;;      # Install configuration files
        b ) backup=true ;;       # Backup configurations
        h ) show_help ;;         # Show help
        \? ) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;  # Invalid option
    esac
done

# Function to restore configurations from backup
restore_configs() {
    echo "Restoring configuration from backups..."
    for folder in "$CONFIG_DIR"/*/; do
        folder_name=$(basename "$folder")
        
        if [ -d "$BACKUPS_DIR/$folder_name" ]; then
            echo "Restoring $folder_name..."
            
            # Ensure proper permissions before restoring
            sudo chown -R "$USER:$USER" "$CONFIG_TARGET_DIR/$folder_name"
            sudo chmod -R u+rw "$CONFIG_TARGET_DIR/$folder_name"

            cp -r "$BACKUPS_DIR/$folder_name" "$CONFIG_TARGET_DIR/"
        else
            echo "Backup for $folder_name not found!"
        fi
    done
}

# Function to create backup of existing configurations
backup_configs() {
    echo "Backing up existing configurations..."
    for folder in "$CONFIG_DIR"/*/; do
        folder_name=$(basename "$folder")
        if [ -d "$CONFIG_TARGET_DIR/$folder_name" ]; then
            echo "Backing up $folder_name..."
            cp -r "$CONFIG_TARGET_DIR/$folder_name" "$BACKUPS_DIR/"
        else
            echo "$folder_name is missing in ~/.config"
        fi
    done
}

# Function to check and install AUR helper (yay or paru)
check_aur_helper() {
    if command -v yay &> /dev/null && ! command -v paru &> /dev/null; then
        AUR_HELPER="yay"
        echo "Using yay as AUR helper."
        read -p "Do you want to switch to paru instead? (y/n): " switch
        if [ "$switch" = "y" ]; then
            echo "Installing paru..."
            git clone https://aur.archlinux.org/paru.git /tmp/paru
            cd /tmp/paru
            makepkg -si --noconfirm
            AUR_HELPER="paru"
        fi
    elif command -v paru &> /dev/null && ! command -v yay &> /dev/null; then
        AUR_HELPER="paru"
        echo "Using paru as AUR helper."
        read -p "Do you want to switch to yay instead? (y/n): " switch
        if [ "$switch" = "y" ]; then
            echo "Installing yay..."
            git clone https://aur.archlinux.org/yay.git /tmp/yay
            cd /tmp/yay
            makepkg -si --noconfirm
            AUR_HELPER="yay"
        fi
    elif command -v yay &> /dev/null && command -v paru &> /dev/null; then
        echo "Both yay and paru are installed."
        echo "Please choose which AUR helper to use:"
        echo "1) yay"
        echo "2) paru"
        read -p "Enter your choice (1 or 2): " choice
        case $choice in
            1) AUR_HELPER="yay" ;;
            2) AUR_HELPER="paru" ;;
            *) echo "Invalid choice. Defaulting to yay."; AUR_HELPER="yay" ;;
        esac
    else
        echo "No AUR helper (yay or paru) found."
        echo "Please choose an AUR helper to install:"
        echo "1) yay"
        echo "2) paru"
        read -p "Enter your choice (1 or 2): " choice
        case $choice in
            1)
                echo "Installing yay..."
                git clone https://aur.archlinux.org/yay.git /tmp/yay
                cd /tmp/yay
                makepkg -si --noconfirm
                AUR_HELPER="yay"
                ;;
            2)
                echo "Installing paru..."
                git clone https://aur.archlinux.org/paru.git /tmp/paru
                cd /tmp/paru
                makepkg -si --noconfirm
                AUR_HELPER="paru"
                ;;
            *)
                echo "Invalid choice. Exiting."
                exit 1
                ;;
        esac
    fi
}

# Function to install new configurations
install_configs() {
    echo "Installing configurations to ~/.config..."
    
    # Update system and install standard packages without confirmation
    sudo pacman -Syu --noconfirm base-devel git hyprlock playerctl conky swaync nvim waybar swaybg kitty rofi-wayland nerd-fonts
    
    # Check for AUR helper and install wlogout
    check_aur_helper
    if [ -n "$AUR_HELPER" ]; then
        echo "Installing wlogout using $AUR_HELPER..."
        $AUR_HELPER -S --noconfirm wlogout
    else
        echo "No AUR helper available. Skipping wlogout installation."
    fi
    
    # Copy configuration files
    for folder in "$CONFIG_DIR"/*/; do
        folder_name=$(basename "$folder")
        echo "Installing $folder_name..."
        cp -r "$CONFIG_DIR/$folder_name" "$CONFIG_TARGET_DIR/"
    done
}

# Main logic
if [ "$restore" = true ]; then
    restore_configs
    exit 0
fi

if [ "$install" = true ]; then
    install_configs
    exit 0
fi

if [ "$backup" = true ]; then
    backup_configs
    exit 0
fi

# Default action (no flags provided)
show_help
