#!/bin/bash

# Define your internal and external display names
# Replace these with your actual display names
INTERNAL_DISPLAY="eDP-1"
EXTERNAL_DISPLAY="HDMI-A-2"

# Initialize variables to track the current state
internal_enabled=true

# Function to get lid state
get_lid_state() {
    if [ -f /proc/acpi/button/lid/LID0/state ]; then
        awk '{print $2}' /proc/acpi/button/lid/LID0/state
    elif [ -f /proc/acpi/button/lid/LID/state ]; then
        awk '{print $2}' /proc/acpi/button/lid/LID/state
    else
        # Fallback method using `grep` if files not found
        cat /proc/acpi/button/lid/LID0/state 2>/dev/null | grep -o 'closed\|open' || echo "unknown"
    fi
}

# Function to check if external monitor is connected
is_external_connected() {
    swaymsg -t get_outputs | jq --arg external "$EXTERNAL_DISPLAY" '.[] | select(.name == $external and .active) | .name' | grep -q "$EXTERNAL_DISPLAY"
}

# Function to dynamically determine the internal display name
detect_internal_display() {
    swaymsg -t get_outputs | jq -r '.[] | select(.internal) | .name'
}

# Update display names dynamically (optional)
# INTERNAL_DISPLAY=$(detect_internal_display)
# EXTERNAL_DISPLAY="HDMI-A-1" # Ensure this matches your external display

# Log file path
LOG_FILE="$HOME/.config/sway/lid_monitor.log"

# Ensure log file directory exists
mkdir -p "$(dirname "$LOG_FILE")"

# Initial setup: ensure internal display is enabled on start
swaymsg output "$INTERNAL_DISPLAY" enable
internal_enabled=true
echo "$(date): Initial state - Enabled $INTERNAL_DISPLAY" >> "$LOG_FILE"

while true; do
    # Get the current lid state
    lid_state=$(get_lid_state)

    # Check if external monitor is connected
    external_connected=false
    if is_external_connected; then
        external_connected=true
    fi

    # Determine desired state based on lid and external monitor
    if [ "$lid_state" = "closed" ] && [ "$external_connected" = true ]; then
        # Desired state: internal display disabled
        if [ "$internal_enabled" = true ]; then
            swaymsg output "$INTERNAL_DISPLAY" disable
            internal_enabled=false
            echo "$(date): Disabled $INTERNAL_DISPLAY" >> "$LOG_FILE"
        fi
    else
        # Desired state: internal display enabled
        if [ "$internal_enabled" = false ]; then
            swaymsg output "$INTERNAL_DISPLAY" enable
            internal_enabled=true
            echo "$(date): Enabled $INTERNAL_DISPLAY" >> "$LOG_FILE"
        fi
    fi

    # Wait for 1 second before next check
    sleep 1
done
