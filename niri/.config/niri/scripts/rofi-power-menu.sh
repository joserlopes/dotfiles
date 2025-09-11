#!/usr/bin/env bash

options=" Lock\n⏾ Logout\n Reboot\n Shutdown"

chosen="$(echo -e "$options" | rofi -dmenu -i -p "Power" \
    -theme-str 'window { width: 20%; } listview { lines: 4; dynamic: true; }')"

case "$chosen" in
    " Lock")
        swaylock -i ~/dotfiles/wallpapers/door.png
        ;;
    "⏾ Logout")
        niri msg action quit
        ;;
    " Reboot")
        systemctl reboot
        ;;
    " Shutdown")
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac
