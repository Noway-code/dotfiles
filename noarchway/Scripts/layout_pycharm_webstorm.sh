#!/bin/bash

# Define workspace numbers
WS1=1
WS2=2

# Function to wait for a window to appear
wait_for_window() {
    local name="$1"
    local timeout=10
    local interval=0.5
    local elapsed=0
    while [ $elapsed -lt $timeout ]; do
        if wmctrl -l | grep -i "$name" > /dev/null; then
            return 0
        fi
        sleep $interval
        elapsed=$(echo "$elapsed + $interval" | bc)
    done
    echo "Window '$name' not found."
    return 1
}

# Launch Workspace 1 Applications
# Launch WebStorm
webstorm &
# Launch PyCharm
pycharm &
# Launch Firefox
firefox &

# Assign Applications to Workspace 1 and arrange them
sleep 2 # Wait for applications to launch

# Move WebStorm to Workspace 1
wmctrl -r "WebStorm" -t $((WS1 - 1))
# Move PyCharm to Workspace 1
wmctrl -r "PyCharm" -t $((WS1 - 1))
# Move Firefox to Workspace 1
wmctrl -r "Firefox" -t $((WS1 - 1))

# Arrange Workspace 1 windows in columns
# Get screen dimensions
SCREEN_WIDTH=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d 'x' -f1)
SCREEN_HEIGHT=$(xdpyinfo | awk '/dimensions:/ {print $2}' | cut -d 'x' -f2)

# Define column widths
COL_WIDTH=$((SCREEN_WIDTH / 3))
COL_HEIGHT=$SCREEN_HEIGHT

# Move and resize WebStorm
wmctrl -r "WebStorm" -e 0,0,0,$COL_WIDTH,$COL_HEIGHT

# Move and resize PyCharm
wmctrl -r "PyCharm" -e 0,$COL_WIDTH,0,$COL_WIDTH,$COL_HEIGHT

# Move and resize Firefox
wmctrl -r "Firefox" -e 0,$((2 * COL_WIDTH)),0,$COL_WIDTH,$COL_HEIGHT

# Launch Workspace 2 Applications
# Launch two terminals (e.g., Alacritty) and Obsidian
alacritty &
alacritty &
obsidian &

sleep 2 # Wait for applications to launch

# Assign Applications to Workspace 2
wmctrl -r "Alacritty" -t $((WS2 - 1))
wmctrl -r "Alacritty" -t $((WS2 - 1))
wmctrl -r "Obsidian" -t $((WS2 - 1))

# Arrange Workspace 2 windows
# Define half-screen dimensions
HALF_WIDTH=$((SCREEN_WIDTH / 2))
FULL_HEIGHT=$SCREEN_HEIGHT

# Calculate stacked terminal heights
TERM_HEIGHT=$((FULL_HEIGHT / 2))

# Move and resize first terminal
wmctrl -r "Alacritty" -e 0,0,0,$HALF_WIDTH,$TERM_HEIGHT

# Move and resize second terminal
wmctrl -r "Alacritty" -e 0,0,$TERM_HEIGHT,$HALF_WIDTH,$TERM_HEIGHT

# Move and resize Obsidian
wmctrl -r "Obsidian" -e 0,$HALF_WIDTH,0,$HALF_WIDTH,$FULL_HEIGHT

# Switch to Workspace 1
hyprctl dispatch workspace $WS1

