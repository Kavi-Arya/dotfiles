#!/usr/bin/env sh

# nowPlaying="$(osascript -e 'tell application "Music" to get name of current track') - $(osascript -e 'tell application "Music" to get album of current track')"
nowPlaying=$(nowplaying-cli get title artist | gpaste -sd '-' | sed 's/-/ - /')
sketchybar --set "$NAME" icon=" " label="Now Playing: $nowPlaying"
