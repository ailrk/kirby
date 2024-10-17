#!/usr/bin/env bash

style="$HOME/.config/rofi/theme/launcher.rasi"
modi=$1

$NIXGL rofi -no-lazy-grab -show "$modi" \
-modi ,drun,window,ssh \
-theme "$style" \
-terminal alacritty \
-run-shell-command '{terminal} -e bash -ic "{cmd} && read"' \
-show-icons
