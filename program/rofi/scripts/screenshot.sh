#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/theme/screenshot.rasi"
msg() { rofi -theme "$HOME/.config/rofi/theme/message.rasi" -e "Please install 'scrot' first." }

screen="";area="";window=""
options="$screen\n$area\n$window"
file="Screenshot_%Y-%m-%d-%S_$wx$h.png"

chosen="$(echo -e "$options" | $rofi_command -p '' -dmenu -selected-row 1)"
if command -v scrot &> /dev/null; then
    case $chosen in
        $screen) sleep 1; scrot $file -e 'mv $f $$(xdg-user-dir PICTURES) ; viewnior $$(xdg-user-dir PICTURES)/$f' ;;
        $area)   scrot -s $file -e 'mv $f $$(xdg-user-dir PICTURES) ; viewnior $$(xdg-user-dir PICTURES)/$f' ;;
        $window) sleep 1; scrot -u $file -e 'mv $f $$(xdg-user-dir PICTURES) ; viewnior $$(xdg-user-dir PICTURES)/$f' ;;
    esac
else
    msg
fi
