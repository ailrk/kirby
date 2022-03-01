#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir=""
rofi_command=""

case  $1 in
    "android")
       dir="$HOME/.config/rofi/theme/android"
        rofi_command="rofi -theme $dir/three.rasi"
        ;;
    "applet")
        case $2 in
            "circle")
                dir="$HOME/.config/rofi/theme/applet/circle"
                ;;
            "rounded")
                dir="$HOME/.config/rofi/theme/applet/rounded"
                ;;
            "square")
                dir="$HOME/.config/rofi/theme/applet/square"
                ;;
        esac
        rofi_command="rofi -theme $dir/screenshot.rasi"
        ;;
esac



# Error msg
msg() {
	rofi -theme "$dir/message.rasi" -e "Please install 'scrot' first."
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

