#!/bin/bash

# Get the current brightness
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)

# Calculate the new brightness
new_brightness=$(( (current_brightness + 250) % 1250 ))

# Update the brightness
echo $new_brightness | sudo tee /sys/class/backlight/intel_backlight/brightness