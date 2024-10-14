#!/usr/bin/env bash

rofi_command="rofi -theme $HOME/.config/rofi/theme/apps.rasi"

# Links
terminal=""
files=""
editor=""
browser=""

# Error msg
msg() {
	rofi -theme "$dir/message.rasi" -e "$1"
}

# Variable passed to rofi
options="$terminal\n$files\n$editor\n$browser"

chosen="$(echo -e "$options" | $rofi_command -p "Most Used" -dmenu -selected-row 0)"
case $chosen in
    $terminal)
		if command -v $TERM &> /dev/null; then
            $TERM &
		else
			msg "No $TERM found!"
		fi
        ;;
    $files)
		if command -v $FILES &> /dev/null; then
            $FILES &
		else
			msg "No $FILES found!"
		fi
        ;;
    $editor)
		if command -v $EDITOR &> /dev/null; then
            $EDITOR &
		else
			msg "No $EDITOR found!"
		fi
        ;;
    $browser)
		if command -v $BROWSER &> /dev/null; then
            $BROWSER &
		else
			msg "No $BROWSER found!"
		fi
        ;;
esac
