#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x



dir=""
rofi_command=""
style=$2

case  $1 in
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
        rofi_command="rofi -theme $dir/time.rasi"
        ;;
esac



## Get time and date
TIME="$(date +"%I:%M %p")"
DN=$(date +"%A")
MN=$(date +"%B")
DAY="$(date +"%d")"
MONTH="$(date +"%m")"
YEAR="$(date +"%Y")"

options="$DAY\n$MONTH\n$YEAR"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "   $DN, $TIME" -dmenu -selected-row 1)"
