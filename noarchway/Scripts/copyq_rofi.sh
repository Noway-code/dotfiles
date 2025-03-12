#!/bin/bash

# Get clipboard history from CopyQ
clipboard_entries=$(copyq read 0 1 2 3 4 5 6 7 8 9 | awk '!seen[$0]++') 

# Show in Rofi and get selected item
selected_entry=$(echo -e "$clipboard_entries" | rofi -dmenu -i -p "Clipboard:" -theme-str 'window {width: 600;}')

# Copy selection back to clipboard
if [ -n "$selected_entry" ]; then
    copyq copy "$selected_entry"
fi

