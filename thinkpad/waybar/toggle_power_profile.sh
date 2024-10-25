#!/bin/bash

# Get battery capacities
battery0_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery1_level=$(cat /sys/class/power_supply/BAT1/capacity)

# Get battery statuses (Charging, Discharging, Full)
battery0_status=$(cat /sys/class/power_supply/BAT0/status)
battery1_status=$(cat /sys/class/power_supply/BAT1/status)

# Check if either battery is charging and if any battery level is greater than 85%
if [[ ("$battery0_status" == "Charging" || "$battery1_status" == "Charging") && ( "$battery0_level" -gt 85 || "$battery1_level" -gt 85 ) ]]; then
    powerprofilesctl set performance
elif [[ "$battery0_level" -gt 50 || "$battery1_level" -gt 50 ]]; then
    powerprofilesctl set balanced
else
    powerprofilesctl set power-saver
fi
