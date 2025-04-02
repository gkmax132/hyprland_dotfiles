#!/bin/bash

THEMES_DIR="$HOME/.config/kitty/themes"
CURRENT_THEME="$HOME/.config/kitty/current-theme.conf"
SOCKET="unix:@mykitty"

if [[ ! -d "$THEMES_DIR" || -z "$(ls -A "$THEMES_DIR")" ]]; then
    notify-send "Kitty Theme Switcher" "Нет доступных тем в $THEMES_DIR"
    exit 1
fi

THEME=$(ls "$THEMES_DIR" | rofi -dmenu -i -p -theme anime "Выберите тему: ")

if [[ -n "$THEME" ]]; then
    cp "$THEMES_DIR/$THEME" "$CURRENT_THEME"

    if pgrep -f "kitty --single-instance" > /dev/null; then
        kitty @ --to "$SOCKET" set-colors --all "$CURRENT_THEME" 2>/dev/null
    else
        kitty --single-instance --listen-on "$SOCKET" -e bash -c "kitty @ --to $SOCKET set-colors --all $CURRENT_THEME; exec fish" &
    fi

    notify-send "Kitty Theme Switcher" "Тема применена: $THEME"
fi
