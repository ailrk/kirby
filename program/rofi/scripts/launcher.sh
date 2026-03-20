#!/usr/bin/env bash

style="$HOME/.config/rofi/theme/launcher.rasi"
modi=$1

pkill rofi || rofi -no-lazy-grab -show "$modi" \
-modi drun,window,ssh \
-theme "$style" \
-terminal "$TERMINAL" \
-run-shell-command '{terminal} -e \\" {cmd}; read -n 1 -s"' \
-kb-mode-next "Alt+space" \
-close-on-unfocus \
-show-icons
