#!/usr/bin/env bash

style="$HOME/.config/rofi/theme/launcher.rasi"
modi=$1

rofi -no-lazy-grab -show "$modi" \
-modi ,drun,window,ssh \
-theme "$style" \
-run-shell-command '{terminal} -e \\" {cmd}; read -n 1 -s"' \
-terminal alacritty \
-show-icons