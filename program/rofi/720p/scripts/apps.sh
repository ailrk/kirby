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
        rofi_command="rofi -theme $dir/apps.rasi"
        ;;
esac


# Links
terminal=""
files=""
editor=""
browser=""
music=""
settings=""

# Error msg
msg() {
	rofi -theme "$dir/message.rasi" -e "$1"
}

# Variable passed to rofi
options="$terminal\n$files\n$editor\n$browser\n$music\n$settings"

chosen="$(echo -e "$options" | $rofi_command -p "Most Used" -dmenu -selected-row 0)"
case $chosen in
    $terminal)
		if command -v alacritty &> /dev/null; then
			alacritty &
		elif command -v termite &> /dev/null; then
			termite &
		elif command -v urxvt &> /dev/null; then
			urxvt &
		elif command -v kitty &> /dev/null; then
			kitty &
		elif command -v xterm &> /dev/null; then
			xterm &
		elif command -v xfce4-terminal &> /dev/null; then
			xfce4-terminal &
		elif command -v gnome-terminal &> /dev/null; then
			gnome-terminal &
		else
			msg "No suitable terminal found!"
		fi
        ;;
    $files)
		if command -v thunar &> /dev/null; then
			thunar &
		elif command -v pcmanfm &> /dev/null; then
			pcmanfm &
		else
			msg "No suitable file manager found!"
		fi
        ;;
    $editor)
		if command -v neovim &> /dev/null; then
            neovim &
		elif command -v geany &> /dev/null; then
			geany &
		elif command -v leafpad &> /dev/null; then
			leafpad &
		elif command -v mousepad &> /dev/null; then
			mousepad &
		elif command -v code &> /dev/null; then
			code &
		else
			msg "No suitable text editor found!"
		fi
        ;;
    $browser)
		if command -v google-chrome-stable &> /dev/null; then
            goole-chrome-stable &
		elif command -v chromium &> /dev/null; then
			chromium &
		elif command -v firefox &> /dev/null; then
			firefox &
		elif command -v midori &> /dev/null; then
			midori &
		else
			msg "No suitable web browser found!"
		fi
        ;;
    $music)
		if command -v lxmusic &> /dev/null; then
			lxmusic &
		else
			msg "No suitable music player found!"
		fi
        ;;
    $settings)
		if command -v xfce4-settings-manager &> /dev/null; then
			xfce4-settings-manager &
		else
			msg "No suitable settings manager found!"
		fi
        ;;
esac

