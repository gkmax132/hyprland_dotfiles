#!/bin/bash

THEME_DIR="$HOME/.config/swaync/themes"
CONFIG_DIR="$HOME/.config/swaync"

SELECTED_THEME=$(ls "$THEME_DIR" | rofi -dmenu --prompt "Выберите тему:")
if [[ -z "$SELECTED_THEME" ]]; then
    exit 0
fi

THEME_PATH="$THEME_DIR/$SELECTED_THEME"

# Убиваем существующий процесс swaync
pkill -x swaync

# Копируем файлы темы в директорию конфигурации swaync
cp -r "$THEME_PATH/"* "$CONFIG_DIR/"

# Запускаем swaync в фоновом режиме
swaync &

# Даем небольшую задержку для запуска
sleep 0.5

# Перезапуск и обновление настроек swaync
swaync-client -R && swaync-client -rs

notify-send "Тема: $SELECTED_THEME"
