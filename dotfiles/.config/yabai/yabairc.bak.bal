#!/usr/bin/env sh

#load scripting addition
sudo yabai --load-sa

# space labels
# yabai -m space 1 --label 
# yabai -m space 2 --label 
# yabai -m space 3 --label 
# yabai -m space 4 --label 
# yabai -m space 5 --label 
# yabai -m space 6 --label 
# yabai -m space 7 --label 
# yabai -m space 8 --label 

#window_border
yabai -m config window_border on
yabai -m config window_border_width 4
yabai -m config active_window_border_color   0xffea6962
yabai -m config normal_window_border_color   0xff1d2021

# folating
yabai -m rule --add app="^System Preferences$" sticky=on layer=above manage=off

#turn off window shadows
yabai -m config window_shadow off

#window gap
yabai -m config layout bsp
yabai -m config top_padding 15
yabai -m config bottom_padding 15
yabai -m config left_padding 15
yabai -m config right_padding 15
yabai -m config window_gap 15

echo "yabai configuration loaded.."
