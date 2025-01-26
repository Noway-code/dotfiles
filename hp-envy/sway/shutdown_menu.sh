#!/usr/bin/env bash

## Author : Customized version
## Github : @adi1090x
#
## Rofi   : Power Menu with Icons and Centered Layout

dir="$HOME/.config/rofi/powermenu/type-1"
theme='style-2'

dir2="$HOME/.config/rofi/powermenu/type-1"
theme2='style-2'

# Power menu options with icons
options="Update System\nLock\nLogout\nReboot\nShutdown"

chosen=$(echo -e "$options" | rofi -dmenu \
    -theme ${dir}/${theme}.rasi \
    -p "Power Menu" \
    -i \
    -no-custom \
    -no-sort \
    -location 0 \
    -width 20 \
    -lines 5 \
    -line-padding 4 \
    -padding 20 \
    -hide-scrollbar \
    -font "JetBrains Mono 12")

confirm() {
    echo -e "No\nYes" | rofi -dmenu \
        -theme ${dir2}/${theme2}.rasi \
        -p "Are you sure?" \
        -i \
        -no-custom \
        -location 0 \
        -width 20 \
        -lines 2 \
        -line-padding 4 \
        -padding 20 \
        -hide-scrollbar \
        -font "JetBrains Mono 12"
}

case "$chosen" in
    *Shutdown)
        if [ "$(confirm)" == "Yes" ]; then
            systemctl poweroff
        fi
        ;;
    *Reboot)
        if [ "$(confirm)" == "Yes" ]; then
            systemctl reboot
        fi
        ;;
    *Logout)
        if [ "$(confirm)" == "Yes" ]; then
            swaymsg exit
        fi
        ;;
    *Lock)
        swaylock -c 000000 --image /home/noway/Pictures/Wallpapers/nord.jpg --scaling fill --indicator-radius 100 --inside-color 00000088 --ring-color 50fa7b
        ;;
    *Update*)
        alacritty -e bash -c "sudo ~/.config/sway/update.sh"
        ;;
esac
