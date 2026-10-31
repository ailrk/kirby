#!/bin/bash
# Get capacity from your env var
cap=$(cat /sys/class/power_supply/"$BATTERY"/capacity)
status=$(cat /sys/class/power_supply/"$BATTERY"/status)

# Choose icon based on capacity
if [ "$status" = "Charging" ]; then
    icon=""
elif [ "$cap" -gt 90 ]; then icon="";
elif [ "$cap" -gt 60 ]; then icon="";
elif [ "$cap" -gt 40 ]; then icon="";
elif [ "$cap" -gt 10 ]; then icon="";
else icon=""; fi

echo "$icon $cap%"
