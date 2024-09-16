#!/usr/bin/env bash

## Author : Customized version
## Github : @adi1090x
#
## Rofi   : Power Menu with Icons and Centered Layout

dir="$HOME/.config/rofi/launchers/type-4"
theme='style-1'

# Power menu options with icons
options=" Lock\n Logout\n Reboot\n Shutdown"

chosen=$(echo -e "$options" | rofi -dmenu \
    -theme ${dir}/${theme}.rasi \
    -p "Power Menu" \
    -i \
    -location 0 \
    -width 20 \
    -lines 4 \
    -line-padding 4 \
    -padding 20 \
    -hide-scrollbar \
    -font "JetBrains Mono 12")

case "$chosen" in
    *Lock) swaylock -c 000000 --image ~/Pictures/TTGL.jpeg --scaling fill --indicator-radius 100 --inside-color 00000088 --ring-color 50fa7b ;;
    *Logout) swaymsg exit ;;
    *Reboot) systemctl reboot ;;
    *Shutdown) systemctl poweroff ;;
esac
