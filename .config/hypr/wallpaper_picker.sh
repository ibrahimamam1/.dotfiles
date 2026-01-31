#!/bin/bash
# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpapers"

# Get a random wallpaper file
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Kill any existing hyprpaper
pkill hyprpaper
sleep 0.5

# Start hyprpaper in background
hyprpaper &
sleep 0.5

# Load and set wallpaper using hyprctl
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "HDMI-A-6,$WALLPAPER"
