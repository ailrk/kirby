#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/theme/network.rasi"

IFACE="$(nmcli | grep -i interface | awk '/interface/ {print $2}')"
STATUS="$(nmcli radio wifi)"

active=""
urgent=""

if (ping -c 1 archlinux.org || ping -c 1 google.com ping -c 1 github.com) &>/dev/null; then
	if [[ $STATUS == *"enable"* ]]; then
        if [[ $IFACE == e* ]]; then
            connected=""
        else
            connected=""
        fi
	active="-a 0"
	SSID="﬉ $(iwgetid -r)"
	PIP="$(wget --timeout=30 http://ipinfo.io/ip -qO -)"
	fi
else
    urgent="-u 0"
    SSID="Disconnected"
    PIP="Not Available"
    connected=""
fi

options="$connected"

chosen="$(echo -e "$options" | $rofi_command -p "$SSID" -dmenu $active $urgent -selected-row 1)"
case $chosen in
    $connected) if [[ $STATUS == *"enable"* ]]; then nmcli radio wifi off; else nmcli radio wifi on; fi ;;
esac
