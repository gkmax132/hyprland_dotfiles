#!/bin/bash

THEME_DIR="$HOME/.config/waybar/themes"
CACHE_FILE="$HOME/.cache/waybar_last_theme"

if [[ "$1" == "-r" ]]; then
    if [[ -f "$CACHE_FILE" ]]; then
        SELECTED_THEME=$(cat "$CACHE_FILE")
        echo "Restoring theme: $SELECTED_THEME"
    else
        echo "No cached theme found." >&2
        exit 1
    fi
else
    SELECTED_THEME=$(ls "$THEME_DIR" | rofi -dmenu --prompt "Select theme:")
    if [[ -z "$SELECTED_THEME" ]]; then
        exit 0
    fi
    echo "$SELECTED_THEME" > "$CACHE_FILE"
fi

THEME_PATH="$THEME_DIR/$SELECTED_THEME"

pkill -x waybar

systemctl --user start xdg-desktop-portal &>/dev/null

sleep 0.5

waybar -c "$THEME_PATH/config.jsonc" -s "$THEME_PATH/style.css" &

notify-send "Theme: $SELECTED_THEME"

