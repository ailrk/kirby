#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/theme/menu.rasi"
Shutdown=" Shutdown"
Reboot=" Reboot"
Lock=" Lock"
Suspend=" Suspend"
Logout=" Logout"


is_yes() {
    [[ $1 == "yes" || $1 == "y" ]]
}

is_no() {
    [[ $1 == "no" || $1 == "n" ]]
}

confirm_exit() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Are You Sure? : "\
		-theme "$HOME"/.config/rofi/theme/confirm.rasi
}

msg() {
    rofi -theme "$HOME/.config/rofi/theme/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$Shutdown\n$Reboot\n$Lock\n$Suspend\n$Logout"

chosen="$(echo -e "$options" | $rofi_command -p "Power Menu" -dmenu -selected-row 2)"
case $chosen in
    "$Shutdown") ans=$(confirm_exit &); if is_yes "$ans"; then systemctl poweroff; elif is_no "$ans"; then exit 0; else msg; fi ;;
    "$Reboot")   ans=$(confirm_exit &); if is_yes "$ans"; then systemctl reboot;   elif is_no "$ans"; then exit 0; else msg; fi ;;
    "$Lock")     dm-tool lock ;;
    "$Suspend")  systemctl suspend ;;
    "$Logout")   bspc quit ;;
esac
