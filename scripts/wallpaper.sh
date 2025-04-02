#!/bin/bash

# Директория для хранения настроек обоев
CACHE_DIR="$HOME/.cache/swaybg"
SETTINGS_FILE="$CACHE_DIR/swaybg_last"

# Создаём директорию для кеша, если её нет
mkdir -p "$CACHE_DIR"

# Функция для установки обоев и сохранения настроек
set_wallpaper() {
    local image="$1"   # Путь к изображению
    local option="${2:--m fill}" # Опция (по умолчанию "fill")

    # Завершаем старый процесс swaybg
    pkill swaybg

    # Запускаем swaybg с заданными параметрами
    swaybg -i "$image" "$option" &

    # Сохраняем команду в файл
    echo "swaybg -i \"$image\" $option &" > "$SETTINGS_FILE"
}

# Функция для восстановления последних обоев
restore_wallpaper() {
    if [[ -f "$SETTINGS_FILE" ]]; then
        # Читаем и выполняем сохранённую команду
        bash -c "$(cat "$SETTINGS_FILE")"
    else
        notify-send "Wallpaper Restore" "No previous wallpaper settings found."
    fi
}

# Проверяем аргументы командной строки
if [[ "$1" == "-r" ]]; then
    # Восстанавливаем последние обои
    restore_wallpaper
elif [[ $# -ge 1 ]]; then
    # Устанавливаем новые обои с опцией (если передана)
    set_wallpaper "$1" "$2"
else
    echo "Использование:"
    echo "  $0 путь_к_изображению [опция] - Установить новые обои (опция по умолчанию: fill)"
    echo "  $0 -r - Восстановить последние обои"
    exit 1
fi

