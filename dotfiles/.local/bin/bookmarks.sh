#!/bin/sh
v="$(cat ~/.local/bin/bookmark.txt | dmenu-mac)" && open $v
