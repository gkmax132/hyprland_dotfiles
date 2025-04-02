#!/bin/bash

# Укажите путь к папке с обоями
WALLPAPER_DIR="$HOME/.wallpaper"
LAST_WALLPAPER_FILE="$HOME/.config/last_wallpaper"
CACHE_DIR="$HOME/.cache/swaybg"
CACHE_FILE="$CACHE_DIR/swaybg_last"

# Создаём директорию для кеша, если её нет
mkdir -p "$CACHE_DIR"

# Проверяем, существует ли папка с обоями
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Fail" "Wrong wallpaper directory"
    exit 1
fi

# Получаем список файлов с обоями через rofi
wallpaper=$(ls "$WALLPAPER_DIR" | while read -r img; do 
    echo -en "$img\x00icon\x1f$WALLPAPER_DIR/$img\n";
done | rofi -dmenu -i -p "Change wallpaper:" -show-icons -theme wallpaper)

# Если пользователь выбрал файл
if [ -n "$wallpaper" ]; then
    # Завершаем уже запущенные экземпляры swaybg
    pkill swaybg

    # Запускаем swaybg с выбранным обоями
    swaybg -i "$WALLPAPER_DIR/$wallpaper" -m fill &

    # Сохраняем команду в файл кеша
    echo "swaybg -i $WALLPAPER_DIR/$wallpaper -m fill &" > "$CACHE_FILE"

    # Уведомляем пользователя
    notify-send "Wallpaper has changed" "$wallpaper"
fi

