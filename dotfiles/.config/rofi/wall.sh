#!/usr/bin/env bash

# 1. Define Paths
WALL_DIR="$HOME/walls"
COLORS_FILE="$HOME/.config/rofi/color.rasi"
LOCK_IMAGE="$HOME/.cache/current_wallpaper"

# Create cache dir if it doesn't exist
mkdir -p "$HOME/.cache"

# 2. Define the Gallery Style using your Everforest variables
STYLE="
@import \"$COLORS_FILE\"

configuration {
    show-icons: true;
}

window {
    width: 1000px;
    height: 650px;
    border: 3px;
    border-color: @selected;
    border-radius: 12px;
    background-color: @background; /* Matches your color.rasi */
}

listview {
    columns: 4;
    lines: 3;
    spacing: 15px;
    margin: 20px;
    fixed-columns: true;
}

element {
    orientation: vertical;
    padding: 10px;
    border-radius: 10px;
    background-color: transparent;
}

element selected {
    background-color: @selected;    /* Matches your color.rasi */
    text-color: @background;       /* Matches your color.rasi */
}

element-icon {
    size: 200px;
    cursor: pointer;
    horizontal-align: 0.5;
}

element-text {
    enabled: false; 
}
"

# 3. Get the list of images
list_wallpapers() {
    find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.jpeg" \) | while read -r img; do
        echo -en "$(basename "$img")\0icon\x1f$img\n"
    done
}

# 4. Run Rofi
choice=$(list_wallpapers | rofi -dmenu -i -theme-str "$STYLE" -p "Select Wallpaper")

# 5. Apply selection
if [ -n "$choice" ]; then
    FULL_PATH="$WALL_DIR/$choice"
    
    # Update Desktop (swww)
    swww img "$FULL_PATH" --transition-type outer --transition-duration 1.5
    
    # Update Lockscreen (hyprlock)
    cp "$FULL_PATH" "$LOCK_IMAGE"
    
    notify-send "Wallpaper Changed" "Applied: $choice" -i "$FULL_PATH"
fi
