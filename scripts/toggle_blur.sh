#!/bin/bash

CONFIG=~/.config/hypr/hyprland.conf
BLUR_ON="decoration {
    blur {
        enabled = true"
BLUR_OFF="decoration {
    blur {
        enabled = false"

if grep -q "enabled = true" "$CONFIG"; then
    sed -i 's/enabled = true/enabled = false/' "$CONFIG"
    notify-send "Blur disabled"
else
    sed -i 's/enabled = false/enabled = true/' "$CONFIG"
    notify-send "Blur enabled"
fi

hyprctl reload

