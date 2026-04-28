#!/bin/sh
# autoStart apps
# Matar procesos previos de forma segura
pkill -9 picom 2>/dev/null
pkill -9 conky 2>/dev/null
pkill -9 volumeicon 2>/dev/null

# systray battery icon
cbatticon -u 5 &
# systray volume
volumeicon &
dunst &

# screen
# xrandr --output DVI-I-1 --off --output HDMI-1 --primary --mode 1920x1080i --pos 0x0 --rotate normal --output VGA-1 --mode 1920x1080 --pos 2031x0 --rotate normal &
# xrandr --output DVI-I-0 --off --output DVI-I-1 --off --output HDMI-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output DVI-D-0 --off
xrandr --output DVI-I-0 --off --output DVI-I-1 --off --output HDMI-0 --mode 1920x1080 --pos 2560x0 --rotate normal --output DP-0 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output DP-1 --off --output DVI-D-0 --off

# conky
killall conky
sleep 3
conky -c ~/.config/conky/conky-form.conf &
# conky -c ~/.config/conky/lua-rings/conky-rings.conf &
# conky -c ~/.config/conky/lua-bars/conky-bars.conf &

killall picom
timeout 5 picom --config ~/.config/picom/picom.conf -b || picom -b &
# picom --config ~/.config/picom/picom.conf &
#nitrogen --restore &
nm-applet &
# gnome-pomodoro &
# feh --bg-fill --randomize /home/robot/Pictures/*.jpg &
feh &

~/.config/qtile/wallpaper.sh
#~/.screenlayout/screen.sh
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
/usr/lib/polkit-kde-authentication-agent-1 &
