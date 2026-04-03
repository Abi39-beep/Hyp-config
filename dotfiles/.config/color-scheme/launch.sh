#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/color-scheme"
CONF_DIR="$HOME/.config"
CACHE_DIR="$HOME/.cache"
ACTIVE_THEME_FILE="$CACHE_DIR/current_theme"
SWITCHER_THEME="$CONF_DIR/rofi/switcher.rasi"

mkdir -p "$CACHE_DIR"

STYLE_WALL="
@import \"$CONF_DIR/rofi/color.rasi\"

configuration {
    show-icons: true;
}

window {
    width: 1000px;
    height: 600px;
    border: 2px;
    border-color: @selected;
    border-radius: 12px;
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
    lines: 2;
    spacing: 15px;
    margin: 0px 20px 20px 20px;
    fixed-columns: false;
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

wallpaper_list() {
    find "$1" -maxdepth 1 -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.svg" -o -iname "*.jfif" \) \
        2>/dev/null | sort
}

apply_theme() {
    local selected_theme theme_path lock_image
    local wallpapers=()
    local auto_wall

    selected_theme=$(
        find "$THEME_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort |
        rofi -dmenu -i -theme "$SWITCHER_THEME" -p "Theme:"
    )

    [ -n "$selected_theme" ] || return 1

    printf '%s\n' "$selected_theme" > "$ACTIVE_THEME_FILE"

    theme_path="$THEME_DIR/$selected_theme"
    lock_image="$CACHE_DIR/current_wallpaper_${selected_theme}"

    echo "@import \"$THEME_DIR/$selected_theme/rofi/$selected_theme.rasi\"" > "$CONF_DIR/rofi/color.rasi"
    echo "include $THEME_DIR/$selected_theme/kitty/$selected_theme.conf" > "$CONF_DIR/kitty/color.conf"
    echo "source = $THEME_DIR/$selected_theme/hyprlock/$selected_theme.conf" > "$CONF_DIR/hypr/color.conf"
    echo "include=$THEME_DIR/$selected_theme/foot/$selected_theme.ini" > "$CONF_DIR/foot/color.ini"
    cp "$THEME_DIR/$selected_theme/nvim/color.lua" "$HOME/.config/nvim/lua/color.lua"
    cp "$THEME_DIR/$selected_theme/noctalia/settings.json" "$HOME/.config/noctalia/settings.json"
    cp "$THEME_DIR/$selected_theme/firefox/userChrome.css" "$HOME/.config/mozilla/firefox/14qna8yw.default-release/chrome/userChrome.css"

    pkill -USR1 kitty 2>/dev/null || true
    hyprctl reload

    mapfile -t wallpapers < <(wallpaper_list "$theme_path")

    if [ "${#wallpapers[@]}" -gt 0 ]; then
        auto_wall="${wallpapers[$((RANDOM % ${#wallpapers[@]}))]}"
        awww img "$auto_wall" --transition-type outer --transition-duration 1.5
        ln -sfn "$auto_wall" "$lock_image"
    else
        rm -f "$lock_image"
        notify-send "Theme Switcher" "Applied $selected_theme theme (No wallpaper found)"
    fi
}

apply_wallpaper() {
    local selected_theme theme_path lock_image current_wall current_index next_index
    local wallpapers=()
    local choice

    if [ -f "$ACTIVE_THEME_FILE" ]; then
        selected_theme=$(<"$ACTIVE_THEME_FILE")
    else
        selected_theme=$(
            find "$THEME_DIR" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | sort |
            rofi -dmenu -i -theme "$SWITCHER_THEME" -p "Theme for wallpaper:"
        )
        [ -n "$selected_theme" ] || return 1
    fi

    theme_path="$THEME_DIR/$selected_theme"
    lock_image="$CACHE_DIR/current_wallpaper_${selected_theme}"

    mapfile -t wallpapers < <(wallpaper_list "$theme_path")

    if [ "${#wallpapers[@]}" -eq 0 ]; then
        notify-send "No Wallpapers" "No images found in $selected_theme folder"
        return 1
    fi

    choice=$(
        for img in "${wallpapers[@]}"; do
            printf '%s\0icon\x1fthumbnail://%s\n' "$img" "$img"
        done | rofi -dmenu -i -show-icons -theme-str "$STYLE_WALL" -p "Wallpaper:"
    )

    [ -n "$choice" ] || return 1

    awww img "$choice" --transition-type outer --transition-duration 1.5
    ln -sfn "$choice" "$lock_image"
}

mode=$(printf "Theme\nWallpaper" | rofi -dmenu -i -theme "$SWITCHER_THEME" -p "Action:")
[ -n "$mode" ] || exit 0

case "$mode" in
    Theme) apply_theme ;;
    Wallpaper) apply_wallpaper ;;
esac
