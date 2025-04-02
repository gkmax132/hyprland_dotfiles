#!/bin/bash
CURRENT_SHELL=$(basename "$SHELL")

THEME_CONF="$HOME/.config/kitty/current-theme.conf"

run_kitty() {
    case "$CURRENT_SHELL" in
        "bash")
            kitty --single-instance --listen-on unix:@mykitty bash -c "kitty @ --to unix:@mykitty set-colors --all $THEME_CONF; exec bash"
            ;;
        "zsh")
            kitty --single-instance --listen-on unix:@mykitty zsh -c "kitty @ --to unix:@mykitty set-colors --all $THEME_CONF; exec zsh"
            ;;
        "fish")
            kitty --single-instance --listen-on unix:@mykitty fish -c "kitty @ --to unix:@mykitty set-colors --all $THEME_CONF; exec fish"
            ;;
        *)
            echo "Unknown shell: $CURRENT_SHELL. Falling back to bash."
            kitty --single-instance --listen-on unix:@mykitty bash -c "kitty @ --to unix:@mykitty set-colors --all $THEME_CONF; exec bash"
            ;;
    esac
}

if [ -f "$THEME_CONF" ]; then
    run_kitty
else
    echo "Error: Theme file $THEME_CONF not found."
    exit 1
fi
