#!/bin/bash

# Directory with animation presets
ANIM_DIR=~/.config/hypr/animations

# Target file for Hyprland
ANIM_FILE=~/.config/hypr/animation.conf

# Check if the directory exists
if [ ! -d "$ANIM_DIR" ]; then
    notify-send "Error" "Animation directory $ANIM_DIR not found!"
    exit 1
fi

# Get list of preset files and remove .conf extension for display
options=$(ls "$ANIM_DIR"/*.conf | xargs -n 1 basename | sed 's/\.conf$//')

# Selection via rofi
choice=$(echo -e "$options" | rofi -dmenu -p "Select Animation Preset")

# Copy the selected preset to animation.conf
if [ -n "$choice" ]; then
    preset_file="$ANIM_DIR/$choice.conf"
    if [ -f "$preset_file" ]; then
        cp "$preset_file" "$ANIM_FILE"
        notify-send "Animations" "Preset applied: $choice"
        hyprctl reload
    else
        notify-send "Error" "Preset $choice not found!"
    fi
fi
