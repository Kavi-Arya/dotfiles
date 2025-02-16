#!/bin/bash

# Read stored number (default to 1 if empty)
count=$(cat /tmp/hypr_num 2>/dev/null)
count=${count:-1}

# Clear the stored number after use
echo -n "" >/tmp/hypr_num

# Execute workspace change multiple times
for ((i = 0; i < count; i++)); do
  hyprctl dispatch workspace "$1"
done
