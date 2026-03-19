#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/theme/menu.rasi"

Chrome=" browser"
Terminal=" terminal"
Filemanager=" files"
Systemd="S systemd"
Launcher=" launcher"


# Variable passed to rofi
options="$Chrome\n$Terminal\n$Filemanager\n$Systemd\n$Launcher"

chosen="$(echo -e "$options" | $rofi_command -p "Quick Access" -dmenu -selected-row 0)"
case $chosen in
    "$Chrome") $BROWSER ;;
    "$Terminal") $TERMINAL ;;
    "$Filemanager") $FILES;;
    "$Systemd") $TERMINAL -e systemctl-tui ;;
    "$Launcher") launcher.sh drun ;;
esac
