#!/usr/bin/env bash

CACHE_DIR="$HOME/.cache"
ACTIVE_THEME_FILE="$CACHE_DIR/current_theme"
LOCK_IMAGE="$CACHE_DIR/current_wallpaper"

# Get current theme (everforest, onedark, etc.)
[ -f "$ACTIVE_THEME_FILE" ] || { notify-send "Error" "No active theme selected"; exit 1; }
THEME=$(cat "$ACTIVE_THEME_FILE")
THEME_PATH="$HOME/.config/color-scheme/$THEME"

# Get wallpapers from theme folder (wall.png, wall2.jpg, etc.)
mapfile -t WALLPAPERS < <(find "$THEME_PATH" -maxdepth 1 -type f \( \
    -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.jpeg" \
\) 2>/dev/null | sort)

[ ${#WALLPAPERS[@]} -eq 0 ] && { 
    notify-send "Error" "No wallpapers in $THEME folder" 
    exit 1 
}

# Find current wallpaper index (wall.png → next is wall2.jpg)
CURRENT_WALL=$(realpath "$LOCK_IMAGE" 2>/dev/null || echo "")
CURRENT_INDEX=0

for i in "${!WALLPAPERS[@]}"; do
    if [[ "${WALLPAPERS[$i]}" == "$CURRENT_WALL" ]]; then
        CURRENT_INDEX=$((i + 1))
        break
    fi
done

# Cycle: wall.png → wall2.jpg → wall.png (loops)
NEXT_INDEX=$((CURRENT_INDEX % ${#WALLPAPERS[@]}))
WALLPAPER="${WALLPAPERS[$NEXT_INDEX]}"

# Apply next wallpaper
awww img "$WALLPAPER" --transition-type outer --transition-duration 0.8
ln -sf "$WALLPAPER" "$LOCK_IMAGE"


