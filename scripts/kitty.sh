#!/bin/bash

# Папка с темами
THEMES_DIR="$HOME/.config/kitty/themes"
# Файл текущей темы
CURRENT_THEME="$HOME/.config/kitty/current-theme.conf"
# Имя сокета
SOCKET="unix:@mykitty"

# Проверяем, есть ли темы
if [[ ! -d "$THEMES_DIR" || -z "$(ls -A "$THEMES_DIR")" ]]; then
    notify-send "Kitty Theme Switcher" "Нет доступных тем в $THEMES_DIR"
    exit 1
fi

# Показываем список тем в Rofi
THEME=$(ls "$THEMES_DIR" | rofi -dmenu -i -p -theme anime "Выберите тему: ")

# Если тема выбрана, применяем её
if [[ -n "$THEME" ]]; then
    cp "$THEMES_DIR/$THEME" "$CURRENT_THEME"

    if pgrep -f "kitty --single-instance" > /dev/null; then
        # Применяем тему только через set-colors
        kitty @ --to "$SOCKET" set-colors --all "$CURRENT_THEME" 2>/dev/null
    else
        # Первый запуск kitty
        kitty --single-instance --listen-on "$SOCKET" -e bash -c "kitty @ --to $SOCKET set-colors --all $CURRENT_THEME; exec fish" &
    fi

    notify-send "Kitty Theme Switcher" "Тема применена: $THEME"
fi
