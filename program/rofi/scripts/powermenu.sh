#!/usr/bin/env bash

# Rofi theme configurations
DIR="$HOME/.config/rofi/theme"
ROFI_CMD="rofi -theme $DIR/menu.rasi -close-on-unfocus"
CONFIRM_CMD="rofi -theme $DIR/confirm.rasi -dmenu -i -p"

# Menu Options
Shutdown="⏻ Shutdown"
Reboot="🔄 Reboot"
Lock="🔒 Lock"
Suspend="🌙 Suspend"
Logout="🚪 Logout"

# Confirmation Menu (Rofi dmenu selection instead of text typing)
confirm_cmd() {
    local action="$1"
    printf " Yes\n No" | $CONFIRM_CMD "Confirm $action?"
}

# Run execution with confirmation check
confirm_run() {
    local action="$1"
    local command="$2"

    selected="$(confirm_cmd "$action")"
    if [[ "$selected" == " Yes" ]]; then
        eval "$command"
    fi
}

# Variable passed to main rofi menu
options="$Shutdown\n$Reboot\n$Lock\n$Suspend\n$Logout"

# Main selection
chosen="$(printf "%b" "$options" | $ROFI_CMD -p "Power Menu" -dmenu -selected-row 2)"

case "$chosen" in
    "$Shutdown")
        confirm_run "Shutdown" "systemctl poweroff"
        ;;
    "$Reboot")
        confirm_run "Reboot" "systemctl reboot"
        ;;
    "$Lock")
        waylock
        ;;
    "$Suspend")
        # Optional: Lock screen before suspending if using waylock
        # waylock & systemctl suspend
        systemctl suspend
        ;;
    "$Logout")
        confirm_run "Logout" "bspc quit"
        ;;
esac
