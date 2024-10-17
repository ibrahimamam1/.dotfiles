#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Get a random wallpaper file
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Update hyprpaper.conf
echo "preload = $WALLPAPER" > "$HOME/.config/hypr/hyprpaper.conf"
echo "wallpaper = ,${WALLPAPER}" >> "$HOME/.config/hypr/hyprpaper.conf"

# Restart hyprpaper (if it's running)
if pgrep -x "hyprpaper" > /dev/null
then
    killall hyprpaper
    hyprpaper &
fi
