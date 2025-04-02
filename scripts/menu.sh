#!/bin/bash

CHOICE=$(echo -e "Change wallpaper\nChange waybar theme\nKitty theme selector\nHypr animation selector\nChange border\nToggle blur" | rofi -dmenu -p "Choose an action")

case "$CHOICE" in
    "Change wallpaper") sh $HOME/.scripts/change_wallpaper.sh ;;
    "Change waybar theme") sh $HOME/.scripts/waybar.sh ;;
    "Kitty theme selector") sh $HOME/.scripts/kitty.sh;;
    "Hypr animation selector") sh $HOME/.scripts/animation.sh;;
    "Change border") sh $HOME/.scripts/change_border.sh;;
    "Toggle blur") sh $HOME/.scripts/toggle_blur.sh ;;
    *) exit 1 ;;
esac

