#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="$HOME/.config/rofi/theme/launcher/squared-material-red.rasi"
modi=$1

rofi -no-lazy-grab -show "$modi" \
-modi ,drun,window,ssh \
-theme $dir/"$style" \
-run-shell-command '{terminal} -e \\" {cmd}; read -n 1 -s"' \
-terminal alacritty \
-show-icons
