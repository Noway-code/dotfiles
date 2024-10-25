#!/usr/bin/env bash

## Author  : Aditya Shakya (adi1090x)
## Github  : @adi1090x
#
## Applets : Brightness

# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Brightness Info
backlight="$(printf "%.0f\n" "$(light -G)")"
card="$(light -L | grep 'backlight' | head -n1 | cut -d'/' -f3)"

if [[ $backlight -ge 0 ]] && [[ $backlight -le 29 ]]; then
    level="Low"
elif [[ $backlight -ge 30 ]] && [[ $backlight -le 49 ]]; then
    level="Optimal"
elif [[ $backlight -ge 50 ]] && [[ $backlight -le 69 ]]; then
    level="High"
elif [[ $backlight -ge 70 ]] && [[ $backlight -le 100 ]]; then
    level="Peak"
fi

# Theme Elements
prompt="${backlight}%"
mesg="Device: ${card}, Level: $level"

if [[ "$theme" == *'type-1'* ]]; then
	list_col='1'
	list_row='3'
	win_width='400px'
elif [[ "$theme" == *'type-3'* ]]; then
	list_col='1'
	list_row='3'
	win_width='120px'
elif [[ "$theme" == *'type-5'* ]]; then
	list_col='1'
	list_row='3'
	win_width='300px'
elif [[ ( "$theme" == *'type-2'* ) || ( "$theme" == *'type-4'* ) ]]; then
	list_col='3'
	list_row='1'
	win_width='550px'
fi

# Options
layout="$(grep 'USE_ICON' "${theme}" | cut -d'=' -f2)"
if [[ "$layout" == 'NO' ]]; then
	option_1=" Increase"
	option_2=" Max"
	option_3=" Decrease"
else
	option_1=""
	option_2=""
	option_3=""
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme "${theme}"
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		light -A 30
	elif [[ "$1" == '--opt2' ]]; then
		light -S 100
	elif [[ "$1" == '--opt3' ]]; then
		# Decrease brightness, but ensure it doesn't go below 5
		current_brightness=$(light -G)
		if (( $(echo "$current_brightness - 30 < 5" | bc -l) )); then
			light -S 5
		else
			light -U 30
		fi
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
esac
