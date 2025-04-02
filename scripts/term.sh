#!/bin/bash
kitty --single-instance --listen-on unix:@mykitty fish -c "kitty @ --to unix:@mykitty set-colors --all ~/.config/kitty/current-theme.conf; exec fish"
