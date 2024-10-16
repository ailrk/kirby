#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/theme/powermenu.rasi"
shutdown="Shutdown";reboot="Reboot";lock="Lock";suspend="Suspend"; logout="Logout"

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
		-theme $HOME/.config/rofi/theme/confirm.rasi
}

msg() {
    rofi -theme "$HOME/.config/rofi/theme/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Power Menu" -dmenu -selected-row 2)"
case $chosen in
    $shutdown) ans=$(confirm_exit &); if is_yes $ans; then systemctl poweroff; elif is_no $ans; then exit 0; else msg; fi ;;
    $reboot)   ans=$(confirm_exit &); if is_yes $ans; then systemctl reboot;   elif is_no $ans; then exit 0; else msg; fi ;;
    $lock)     dm-tool lock ;;
    $suspend)  ans=$(confirm_exit &); if is_yes $ans; then amixer set Master mute; systemctl suspend; elif is_no $ans; then exit 0; else msg; fi ;;
    $logout)   ans=$(confirm_exit &); if is_yes $ans; then bspc quit; elif is_no $ans; then exit 0; else msg; fi ;;
esac
