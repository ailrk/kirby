#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

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
        rofi_command="rofi -theme $dir/quicklinks.rasi"
        ;;
esac



## Get Volume
#VOLUME=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%')
MUTE=$(amixer get Master | tail -n 1 | awk -F ' ' '{print $6}' | tr -d '[]%')

active=""
urgent=""

if [[ $MUTE == *"off"* ]]; then
    active="-a 1"
else
    urgent="-u 1"
fi

if [[ $MUTE == *"off"* ]]; then
    active="-a 1"
else
    urgent="-u 1"
fi

if [[ $MUTE == *"on"* ]]; then
    VOLUME="$(amixer get Master | tail -n 1 | awk -F ' ' '{print $5}' | tr -d '[]%')%"
else
    VOLUME="Mu..."
fi

## Icons
ICON_UP=""
ICON_DOWN=""
ICON_MUTED=""

options="$ICON_UP\n$ICON_MUTED\n$ICON_DOWN"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$VOLUME" -dmenu $active $urgent -selected-row 0)"
case $chosen in
    $ICON_UP)
        amixer -Mq set Master,0 5%+ unmute && notify-send -u low -t 1500 "Volume Up $ICON_UP"
        ;;
    $ICON_DOWN)
        amixer -Mq set Master,0 5%- unmute && notify-send -u low -t 1500 "Volume Down $ICON_DOWN"
        ;;
    $ICON_MUTED)
        amixer -q set Master toggle
        ;;
esac

