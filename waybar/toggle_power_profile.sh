#!/bin/bash

# Get battery capacities
battery0_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery1_level=$(cat /sys/class/power_supply/BAT1/capacity)

# Get battery statuses (Charging, Discharging, Full)
battery0_status=$(cat /sys/class/power_supply/BAT0/status)
battery1_status=$(cat /sys/class/power_supply/BAT1/status)

# Check if either battery is charging
if [[ "$battery0_status" == "Charging" || "$battery1_status" == "Charging" ]]; then
    # If either battery is charging, set to performance
    powerprofilesctl set performance
else
    # Neither is charging, check battery levels
    if [[ "$battery0_level" -gt 50 || "$battery1_level" -gt 50 ]]; then
        # If at least one battery is above 50%, set to balanced
        powerprofilesctl set balanced
    else
        # If both batteries are 50% or below, set to power-saver
        powerprofilesctl set power-saver
    fi
fi
