#!/bin/bash

chosen=$(echo -e "Lock\nLogout\nReboot\nShutdown" | wofi --show dmenu --prompt "Select option:")

case "$chosen" in
    Lock) swaylock -c 000000 --image ~/Pictures/TTGL.jpeg --scaling fill --indicator-radius 100 --inside-color 00000088 --ring-color 50fa7b ;;
    Logout) swaymsg exit ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac
