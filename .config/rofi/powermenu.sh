#!/bin/sh

# Opciones del menú
chosen=$(printf "󰐥 Power Off\n󰜉 Restart\n󰍁 Lock\n󰗼 Logout" |
  rofi -dmenu \
    -i \
    -p "  Power" \
    -theme ~/.config/rofi/power.rasi)

case "$chosen" in
"󰐥 Power Off") systemctl poweroff ;;
"󰜉 Restart") systemctl reboot ;;
"󰍁 Lock") i3lock -c 11111b ;; # o betterlockscreen -l
"󰗼 Logout") qtile cmd-obj -o cmd -f shutdown ;;
*) exit 1 ;;
esac
