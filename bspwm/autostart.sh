#!/bin/sh

FILE="/etc/X11/xorg.conf/20-nvidia.conf"

### MY ADDS ###
function pc () {
  feh --bg-scale /home/kvl/Pictures/wallpapers/Spaceman-Dracula.png &
  xset r rate 350 75 &
  setxkbmap -option caps:super &
  pgrep -x picom > /dev/null || picom -b &
 dunst &
  xrandr --output HDMI-0 --mode 1920x1080 --rate 144 &
  # xrandr --output eDP-1-1 --off  &
  nvidia-settings --load-config-only &
  nvidia-settings -a "DigitalVibrance=300" &
  brightnessctl -d "intel_backlight" set 0% &
  xinput disable "SYNA7DB5:01 06CB:CD41 Touchpad" &
  xinput disable "AT Translated Set 2 keyboard" &
  xinput disable "HD User Facing: HD User Facing" &
  xsetroot -cursor_name cross & 
  echo "PC"
}
function laptop () {
  feh --bg-scale /home/kvl/Pictures/wallpapers/Spaceman-Dracula.png &
  xset r rate 350 75 &
  setxkbmap -option caps:super &
  pgrep -x picom > /dev/null || picom -b &
  dunst &
  xsetroot -cursor_name cross & 
  echo "LAPTOP"
}

if test -f "/etc/X11/xorg.conf.d/20-nvidia.conf"; then
   pc 
else
  laptop
fi
