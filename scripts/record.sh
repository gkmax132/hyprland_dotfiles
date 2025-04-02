#!/bin/bash

CHOICE=$(echo -e "Screen full area\nRecord video" | rofi -dmenu -p "Выбери действие:")

case "$CHOICE" in
    "Screen full area") FILE=~/Pictures/Screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png
mkdir -p ~/Pictures/Screenshots
sleep 0.8
grim "$FILE" && wl-copy < "$FILE" ;;
    "Record video")  ;;
    *) exit 1 ;;
esac

