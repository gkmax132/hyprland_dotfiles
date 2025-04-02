#!/bin/bash

# Directory with border presets
BORDER_DIR=~/.config/hypr/borders

# Target file for Hyprland
BORDER_FILE=~/.config/hypr/border.conf

# Check if the directory exists
if [ ! -d "$BORDER_DIR" ]; then
    notify-send "Error" "Border directory $BORDER_DIR not found!"
    exit 1
fi

# Get list of preset files and remove .conf extension for display
options=$(ls "$BORDER_DIR"/*.conf | xargs -n 1 basename | sed 's/\.conf$//')

# Selection via rofi
choice=$(echo -e "$options" | rofi -dmenu -p -theme anime "Select Border Color")

# Copy the selected preset to border.conf
if [ -n "$choice" ]; then
    preset_file="$BORDER_DIR/$choice.conf"
    if [ -f "$preset_file" ]; then
        cp "$preset_file" "$BORDER_FILE"
        notify-send "Border" "Color preset applied: $choice"
        hyprctl reload
    else
        notify-send "Error" "Preset $choice not found!"
    fi
fi
