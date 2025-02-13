#!/bin/bash
MODE="$HOME/.config/hypr/mode.txt"

# Ensure mode.txt exists
if [ ! -f "$MODE" ]; then
  echo "Error: mode.txt not found!"
  exit 1
fi

# Function to check the current mode, output text, and signal waybar
update_mode() {
  mode=$(< "$MODE")
  if [[ "$mode" == "Normal Mode" ]]; then
    echo "Normal Mode"
    cp -r ~/.config/waybar/MODES/colors-Normal-Mode.css ~/.config/waybar/colors.css
    # pkill -SIGUSR2 waybar
  elif [[ "$mode" == "Insert Mode" ]]; then
    echo "Insert Mode"
    cp -r ~/.config/waybar/MODES/colors-Insert-Mode.css ~/.config/waybar/colors.css
  elif [[ "$mode" == "Site Mode" ]]; then
    echo "Insert Mode"
    cp -r ~/.config/waybar/MODES/colors-Site-Mode.css ~/.config/waybar/colors.css
  elif [[ "$mode" == "Run Mode" ]]; then
    echo "Insert Mode"
    cp -r ~/.config/waybar/MODES/colors-Run-Mode.css ~/.config/waybar/colors.css
    # pkill -SIGUSR2 waybar
  else
    echo "Unknown mode: $mode"
  fi
}

# Read initial mode and signal once
last_mode=$(< "$MODE")
update_mode

# Check if inotifywait is available
if ! command -v inotifywait &> /dev/null; then
  echo "inotifywait is required but not installed. Install inotify-tools and try again."
  exit 1
fi

# Monitor mode.txt for changes
while inotifywait -e modify "$MODE"; do
  new_mode=$(< "$MODE")
  if [[ "$new_mode" != "$last_mode" ]]; then
    last_mode="$new_mode"
    update_mode
  fi
done

