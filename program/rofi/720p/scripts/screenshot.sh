#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/theme/screenshot.rasi"

# Error msg
msg() {
	rofi -theme "$HOME/.config/rofi/theme/message.rasi" -e "Please install 'scrot' first."
}

# Options
screen=""
area=""
window=""

# Variable passed to rofi
options="$screen\n$area\n$window"

chosen="$(echo -e "$options" | $rofi_command -p '' -dmenu -selected-row 1)"
if command -v scrot &> /dev/null; then
    case $chosen in
        $screen)
            sleep 1; scrot 'Screenshot_%Y-%m-%d-%S_$wx$h.png' -e 'mv $f $$(xdg-user-dir PICTURES) ; viewnior $$(xdg-user-dir PICTURES)/$f'
            ;;
        $area)
            scrot -s 'Screenshot_%Y-%m-%d-%S_$wx$h.png' -e 'mv $f $$(xdg-user-dir PICTURES) ; viewnior $$(xdg-user-dir PICTURES)/$f'
            ;;
        $window)
            sleep 1; scrot -u 'Screenshot_%Y-%m-%d-%S_$wx$h.png' -e 'mv $f $$(xdg-user-dir PICTURES) ; viewnior $$(xdg-user-dir PICTURES)/$f'
            ;;
    esac
else
    msg
fi
