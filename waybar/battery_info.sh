#!/bin/bash
battery_name=$1

battery_info=$(upower -i /org/freedesktop/UPower/devices/battery_${battery_name} | grep -E "state|time to empty|percentage|time to full")
notify-send "Battery ${battery_name} Info" "$battery_info"
