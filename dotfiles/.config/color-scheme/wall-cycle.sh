#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/color-scheme"
CACHE_DIR="$HOME/.cache"
ACTIVE_THEME_FILE="$CACHE_DIR/current_theme"

mkdir -p "$CACHE_DIR"

[ -f "$ACTIVE_THEME_FILE" ] || { notify-send "Error" "No active theme selected"; exit 1; }

THEME=$(<"$ACTIVE_THEME_FILE")
THEME_PATH="$THEME_DIR/$THEME"
LOCK_IMAGE="$CACHE_DIR/current_wallpaper_${THEME}"

mapfile -t WALLPAPERS < <(
    find "$THEME_PATH" -maxdepth 1 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.svg" -o -iname "*.jfif" \) \
        2>/dev/null | sort
)

[ "${#WALLPAPERS[@]}" -gt 0 ] || { notify-send "Error" "No wallpapers in $THEME folder"; exit 1; }

CURRENT_WALL=""
[ -L "$LOCK_IMAGE" ] && CURRENT_WALL=$(readlink -f "$LOCK_IMAGE" 2>/dev/null || true)

CURRENT_INDEX=-1
for i in "${!WALLPAPERS[@]}"; do
    if [ "$(readlink -f "${WALLPAPERS[$i]}")" = "$CURRENT_WALL" ]; then
        CURRENT_INDEX=$i
        break
    fi
done

NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))
WALLPAPER="${WALLPAPERS[$NEXT_INDEX]}"

awww img "$WALLPAPER" --transition-type outer --transition-duration 0.8
ln -sfn "$WALLPAPER" "$LOCK_IMAGE"
