#!/bin/bash

CACHE_DIR="$HOME/.cache/swaybg"
SETTINGS_FILE="$CACHE_DIR/swaybg_last"

mkdir -p "$CACHE_DIR"

set_wallpaper() {
    local image="$1"   
    local option="${2:--m fill}" 

    pkill swaybg

    swaybg -i "$image" "$option" &

    echo "swaybg -i \"$image\" $option &" > "$SETTINGS_FILE"
}

restore_wallpaper() {
    if [[ -f "$SETTINGS_FILE" ]]; then
        bash -c "$(cat "$SETTINGS_FILE")"
    else
        notify-send "Wallpaper Restore" "No previous wallpaper settings found."
    fi
}

if [[ "$1" == "-r" ]]; then
    restore_wallpaper
elif [[ $# -ge 1 ]]; then
    set_wallpaper "$1" "$2"
else
    echo "Usage:"
    echo "  $0 image_path [option] - Set new wallpaper (default option: fill)"
    echo "  $0 -r - Restore the last wallpaper"
    exit 1
fi

