#!/bin/bash

THEMES_DIR="$HOME/.config/kitty/themes"
CURRENT_THEME="$HOME/.config/kitty/current-theme.conf"
SOCKET="unix:@mykitty"

# Check if themes directory exists and is not empty
if [[ ! -d "$THEMES_DIR" || -z "$(ls -A "$THEMES_DIR")" ]]; then
    notify-send "Kitty Theme Switcher" "Themes not found in $THEMES_DIR"
    exit 1
fi

# Show theme selection menu with rofi
THEME=$(ls "$THEMES_DIR" | rofi -dmenu -i -p "Select theme: ")

if [[ -n "$THEME" ]]; then
    # Copy selected theme to current-theme.conf
    cp "$THEMES_DIR/$THEME" "$CURRENT_THEME"

    # Detect current shell
    CURRENT_SHELL=$(basename "$SHELL")
    if [[ -z "$CURRENT_SHELL" ]]; then
        # Fallback: get shell from /etc/passwd if $SHELL is not set
        CURRENT_SHELL=$(getent passwd "$USER" | cut -d: -f7 | xargs basename)
    fi

    if pgrep -f "kitty --single-instance" > /dev/null; then
        # If kitty is already running, update colors
        kitty @ --to "$SOCKET" set-colors --all "$CURRENT_THEME" 2>/dev/null
    else
        # If kitty is not running, start it with the current shell
        kitty --single-instance --listen-on "$SOCKET" -e bash -c "kitty @ --to $SOCKET set-colors --all $CURRENT_THEME; exec $CURRENT_SHELL" &
    fi

    notify-send "Kitty Theme Switcher" "Applied theme: $THEME"
f
