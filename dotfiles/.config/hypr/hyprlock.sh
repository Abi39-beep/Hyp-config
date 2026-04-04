#!/bin/bash
THEME=$(cat ~/.cache/current_theme)
WALLPAPER=$(readlink -f ~/.cache/current_wallpaper_$THEME)
export HYPRLOCK_WALLPAPER="$WALLPAPER"
hyprlock
