#!/usr/bin/env bash

WALL_DIR="$HOME/walls"
COLORS_FILE="$HOME/.config/rofi/color.rasi"
LOCK_IMAGE="$HOME/.cache/current_wallpaper"

mkdir -p "$HOME/.cache"

# --- STYLE FOR WALLPAPER GRID ---
STYLE="
@import \"$COLORS_FILE\"

configuration {
    show-icons: true;
}

window {
    width: 1000px;
    height: 600px;
    border: 2px;
    border-color: @selected;
    border-radius: 12px;
    /* Semi-transparent background for frosted glass (60% opacity) */
    background-color: @background;
}

mainbox {
    background-color: transparent;
    children:[ inputbar, listview ];
    spacing: 15px;
    padding: 10px;
}

inputbar {
    background-color: transparent;
    text-color: @foreground;
    children:[ prompt, entry ];
    padding: 10px 20px;
}

prompt {
    background-color: transparent;
    text-color: @foreground;
    margin: 0px 5px 0px 0px;
}

entry {
    background-color: transparent;
    text-color: @foreground;
    placeholder: \"Search...\";
    placeholder-color: gray;
}

listview {
    background-color: transparent;
    columns: 4;
    lines: 3;
    spacing: 15px;
    margin: 0px 20px 20px 20px;
    fixed-columns: true;
    border: 0px;
    scrollbar: false;
}

element {
    orientation: vertical;
    padding: 10px;
    border-radius: 10px;
    background-color: transparent;
}

element normal.normal, element alternate.normal {
    background-color: transparent;
    text-color: @foreground;
}

element selected.normal {
    background-color: @selected;
    text-color: @background;
    border-color: @selected;
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

# --- STYLE FOR THEME LIST ---
STYLE_THEME="
@import \"$COLORS_FILE\"

configuration {
    show-icons: false;
}

window {
    width: 350px;
    border: 2px;
    border-color: @selected;
    border-radius: 15px;
    /* Semi-transparent background for frosted glass (60% opacity) */
    background-color: @background;
    padding: 10px;
}

mainbox {
    background-color: transparent;
    children:[ inputbar, listview ];
    spacing: 15px;
}

inputbar {
    background-color: transparent;
    text-color: @foreground;
    children: [ prompt, entry ];
    padding: 5px 15px;
}

prompt {
    background-color: transparent;
    text-color: @foreground;
    margin: 0px 5px 0px 0px;
}

entry {
    background-color: transparent;
    text-color: @foreground;
    placeholder: \"Search...\";
    placeholder-color: gray;
}

listview {
    background-color: transparent;
    columns: 1;
    lines: 5;
    spacing: 8px;
    fixed-height: false;
    dynamic: true;
    border: 0px;
    scrollbar: false;
}

element {
    padding: 10px 15px;
    border-radius: 8px;
    background-color: transparent;
    text-color: @foreground;
}

element normal.normal, element alternate.normal {
    background-color: transparent;
    text-color: @foreground;
}

element selected.normal {
    background-color: @selected;
    text-color: @background;
}
"

# 1️⃣ Select Theme Folder
theme=$(find "$WALL_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | rofi -dmenu -i -theme-str "$STYLE_THEME" -p "Walls:")
[ -z "$theme" ] && exit 0

THEME_DIR="$WALL_DIR/$theme"

# 2️⃣ List Wallpapers Inside Selected Folder
list_wallpapers() {
    find "$THEME_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.jpeg" \) | while read -r img; do
        echo -en "$img\0icon\x1f$img\n"
    done
}

choice=$(list_wallpapers | rofi -dmenu -i -theme-str "$STYLE" -p "Wallpaper:")

# 3️⃣ Apply Wallpaper
if [ -n "$choice" ]; then
    swww img "$choice" --transition-type outer --transition-duration 1.5
    cp "$choice" "$LOCK_IMAGE"
    notify-send "Wallpaper Changed" "Applied: $(basename "$choice")" -i "$choice"
fi
