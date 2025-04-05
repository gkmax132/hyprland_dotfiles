#!/bin/bash

THEME_DIR="$HOME/.config/swaync/themes"
CONFIG_DIR="$HOME/.config/swaync"

SELECTED_THEME=$(ls "$THEME_DIR" | rofi -dmenu --prompt "Select theme:")
if [[ -z "$SELECTED_THEME" ]]; then
    exit 0
fi

THEME_PATH="$THEME_DIR/$SELECTED_THEME"

pkill -x swaync

cp -r "$THEME_PATH/"* "$CONFIG_DIR/"

swaync &

sleep 0.5

swaync-client -R && swaync-client -rs

notify-send "Тема: $SELECTED_THEME"
