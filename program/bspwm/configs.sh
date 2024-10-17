#!/bin/bash
# Each user has its own bspwm config `bspwmrc` that's specific to a machine
# This script contains the shared configs among all machines

# Environment
setup_paths() {
    export PATH="${PATH}:$HOME/.config/scripts"
}

bspwm_configs() {
    bspc config top_padding          70
    bspc config bottom_padding       10
    bspc config left_padding         20
    bspc config right_padding        20
    bspc config border_width         3
    bspc config window_gap           5
    bspc config borderless_monocle   true
    bspc config focused_border_color $WHITE
    bspc config split_ratio          0.5
    bspc config presel_border_color "#ffbec9"
}

bspwm_rules() {
    bspc rule -r *:* # remove existing rules
}

background() {
    dunstify "(づ｡◕‿◕｡)づ !"
    file1="$HOME/.config/bspwm/background/jWTBsU0.jpg"
    feh --bg-fill $file1
}

init_sxhkd() {
    sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
}

init_polybar() {
    $HOME/.config/polybar/start.sh &
}

init_dunst() {
    dunst \
        -1b "$WHITE" -1f "$BLACK" -1fr "$BLACK" \
        -nb "$WHITE" -nf "$BLACK" -nfr "$BLACK" \
        -cb "$WHITE" -cf "$BLACK" -cfr "$BLACK" &
}
