#!/bin/sh

nitrogen --restore &
xset r rate 350 75 &
setxkbmap -option caps:escape &
pgrep -x picom > /dev/null || picom -b &
xrandr --output HDMI-1 --mode 2560x1080 --rate 100 &
xsetroot -cursor_name cross & 
