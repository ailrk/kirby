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
        rofi_command="rofi -theme $dir/six.rasi"
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



# Error msg
msg() {
	rofi -theme "$dir/message.rasi" -e "$1"
}

# Browser
if command -v goolge-chrome-stable &> /dev/null; then
	app="google-chrome-stable"
elif command -v chromium &> /dev/null; then
	app="chromium"
elif command -v firefox &> /dev/null; then
	app="firefox"
elif command -v midori &> /dev/null; then
	app="midori"
else
	msg "No suitable web browser found!"
	exit 1
fi

# Links
google=""
facebook=""
twitter=""
github=""
mail=""
youtube=""

# Variable passed to rofi
options="$google\n$facebook\n$twitter\n$github\n$mail\n$youtube"

chosen="$(echo -e "$options" | $rofi_command -p "Open In  :  Firefox" -dmenu -selected-row 0)"
case $chosen in
    $google)
        $app https://www.google.com &
        ;;
    $facebook)
        $app https://www.facebook.com &
        ;;
    $twitter)
        $app https://www.twitter.com &
        ;;
    $github)
        $app https://www.github.com &
        ;;
    $mail)
        $app https://www.gmail.com &
        ;;
    $youtube)
        $app https://www.youtube.com &
        ;;
esac

