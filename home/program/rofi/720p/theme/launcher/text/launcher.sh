#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

# Available Styles
# >> Created and tested on : rofi 1.6.0-1
#
# style_1     style_2     style_3     style_4     style_5     style_6     style_7

dir=""
rofi_command=""

style=$2

case  $1 in
    "text")
        dir="$HOME/.config/rofi/theme/launcher/text"
        rofi_command="rofi -theme $dir/$style.rasi"
        ;;
    "ribbon")
        dir="$HOME/.config/rofi/theme/launcher/ribbon"
        rofi_command="rofi -theme $dir/$style.rasi"
        ;;
esac


styles=($(ls -p --hide="colors.rasi" $dir/styles))
color="${styles[$(( $RANDOM % 10 ))]}"

# comment this line to disable random colors
sed -i -e "s/@import .*/@import \"$color\"/g" $dir/styles/colors.rasi

# comment these lines to disable random style
themes=($(ls -p --hide="launcher.sh" --hide="styles" $dir))
theme="${themes[$(( $RANDOM % 7 ))]}"

rofi -no-lazy-grab -show drun \
-modi run,drun,window \
-theme $dir/"$theme"

