#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

dir="$HOME/.config/rofi/applets/android"
rofi_command="rofi -theme $dir/three.rasi"

# Error msg
msg() {
	rofi -theme "$dir/message.rasi" -e "$1"
}

## Get Brightness
if command -v brightnessctl &> /dev/null; then
	BNESS="$(brightnessctl get)"
	MAX="$(brightnessctl max)"
	PERC="$((BNESS*100/MAX))"
	BLIGHT=${PERC%.*}
elif command -v blight &> /dev/null; then
	DEVICE=$(ls /sys/class/backlight | head -n 1)
	BNESS="$(blight -d $DEVICE get brightness)"
	PERC="$(($BNESS*100/255))"
	BLIGHT=${PERC%.*}
elif command -v xbacklight &> /dev/null; then
	VAR="$(xbacklight -get)"
	BLIGHT="$(printf "%.0f\n" "$VAR")"
else
	msg "No suitable backlight utility found!"
	exit 1
fi

if [[ $BLIGHT -ge 1 ]] && [[ $BLIGHT -le 29 ]]; then
    MSG="Low"
elif [[ $BLIGHT -ge 30 ]] && [[ $BLIGHT -le 49 ]]; then
    MSG="Optimal"
elif [[ $BLIGHT -ge 50 ]] && [[ $BLIGHT -le 69 ]]; then
    MSG="High"
elif [[ $BLIGHT -ge 70 ]] && [[ $BLIGHT -le 99 ]]; then
    MSG="Too Much"
fi

## Icons
ICON_UP=""
ICON_DOWN=""
ICON_OPT=""

notify="notify-send -u low -t 1500"
options="$ICON_UP\n$ICON_OPT\n$ICON_DOWN"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$BLIGHT%" -dmenu -selected-row 1)"
case $chosen in
    "$ICON_UP")
		if command -v brightnessctl &> /dev/null; then
			brightnessctl -q set +10% && $notify "Brightness Up $ICON_UP"
		elif command -v blight &> /dev/null; then
			blight -d "$DEVICE" set +10% && $notify "Brightness Up $ICON_UP"
		elif command -v xbacklight &> /dev/null; then
			xbacklight -inc 10 && $notify "Brightness Up $ICON_UP"
		fi
        ;;
    "$ICON_DOWN")
		if command -v brightnessctl &> /dev/null; then
			brightnessctl -q set 10%- && $notify "Brightness Down $ICON_DOWN"
		elif command -v blight &> /dev/null; then
			blight -d "$DEVICE" set -10% && $notify "Brightness Down $ICON_DOWN"
		elif command -v xbacklight &> /dev/null; then
			xbacklight -dec 10 && $notify "Brightness Down $ICON_DOWN"
		fi
        ;;
    "$ICON_OPT")
		if command -v brightnessctl &> /dev/null; then
			brightnessctl -q set 25% && $notify "Optimal Brightness $ICON_OPT"
		elif command -v blight &> /dev/null; then
			blight -d "$DEVICE" set 25% && $notify "Optimal Brightness $ICON_OPT"
		elif command -v xbacklight &> /dev/null; then
			xbacklight -set 30 && $notify "Optimal Brightness $ICON_OPT"
		fi
        ;;
esac

