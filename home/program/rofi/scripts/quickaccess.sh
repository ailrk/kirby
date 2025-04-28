#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/theme/menu.rasi"

Chrome=" browser"
Terminal=" terminal"
Filemanager=" files"
Audio=" audio"
Htop="H htop"
Systemd="S systemd"
Bluetooth=" bluetooth"
Launcher=" Launcher"
Nixbuild=" Nix Build"


# Variable passed to rofi
options="$Chrome\n$Terminal\n$Filemanager\n$Audio\n$Bluetooth\n$Htop\n$Systemd\n$Launcher\n$Nixbuild"

chosen="$(echo -e "$options" | $rofi_command -p "Quick Access" -dmenu -selected-row 0)"
case $chosen in
    "$Chrome") $BROWSER ;;
    "$Terminal") $TERMINAL ;;
    "$Filemanager") $FILES;;
    "$Audio")
        if command -v pulseaudio >/dev/null 2>&1; then
          pulseaudio --start
        elif command -v pavucontrol >/dev/null 2>&1; then
          pavucontrol
        else
          echo "neither pulseaudio nor pavucontrol found."
        fi ;;
    "$Htop") $TERMINAL -e htop ;;
    "$Systemd") $TERMINAL -e systemctl-tui ;;
    "$Bluetooth") blueman-manager ;;
    "$Launcher") launcher.sh drun ;;
    "$Nixbuild") rebuildhm ;;
esac
