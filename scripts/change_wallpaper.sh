#!/bin/bash

WALLPAPER_DIR="$HOME/.wallpaper"
LAST_WALLPAPER_FILE="$HOME/.config/last_wallpaper"
CACHE_DIR="$HOME/.cache/swaybg"
CACHE_FILE="$CACHE_DIR/swaybg_last"

mkdir -p "$CACHE_DIR"

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Fail" "Wrong wallpaper directory"
    exit 1
fi

wallpaper=$(ls "$WALLPAPER_DIR" | while read -r img; do 
    echo -en "$img\x00icon\x1f$WALLPAPER_DIR/$img\n";
done | rofi -dmenu -i -p "Change wallpaper:" -show-icons -theme wallpaper)

if [ -n "$wallpaper" ]; then
    pkill swaybg

    swaybg -i "$WALLPAPER_DIR/$wallpaper" -m fill &

    echo "swaybg -i $WALLPAPER_DIR/$wallpaper -m fill &" > "$CACHE_FILE"

    notify-send "Wallpaper has changed" "$wallpaper"
fi
