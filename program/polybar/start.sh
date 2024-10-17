#!/usr/bin/env sh

sleep .1

if ! pgrep -x polybar; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload main &
    done
else
	pkill -USR1 polybar
fi

echo "Bars launched..."
