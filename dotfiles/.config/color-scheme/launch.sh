#!/usr/bin/env bash
set -euo pipefail

THEME_DIR="$HOME/.config/color-scheme"
CONF_DIR="$HOME/.config"
CACHE_DIR="$HOME/.cache"
ACTIVE_THEME_FILE="$CACHE_DIR/current_theme"
SWITCHER_THEME="$CONF_DIR/rofi/switcher.rasi"
WALLPAPER_THEME="$CONF_DIR/rofi/wallpaper.rasi"

mkdir -p "$CACHE_DIR"

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
        rofi -dmenu -i -theme "$SWITCHER_THEME" -p " Theme:"
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
    cp "$THEME_DIR/$selected_theme/firefox/userChrome.css" "$HOME/.config/mozilla/firefox/14qna8yw.default-release/chrome/userChrome.css"
    cp "$THEME_DIR/$selected_theme/quickshell/Colors.qml" "$HOME/.config/quickshell/qubar/Colors.qml"
    cp "$THEME_DIR/$selected_theme/quickshell/Colors.qml" "$HOME/.config/quickshell/OSD/Colors.qml"
    cp "$THEME_DIR/$selected_theme/hyprland/Colors.lua" "$HOME/.config/hypr/Modules/Colors.lua"
    cp "$THEME_DIR/$selected_theme/zen/$selected_theme.css" "$HOME/.config/zen/rcasz579.Default (release)/chrome/userChrome.css"


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
        done | rofi -dmenu -i -show-icons -theme "$WALLPAPER_THEME" -p "Wallpaper:"
    )

    [ -n "$choice" ] || return 1

    awww img "$choice" --transition-type outer --transition-duration 1.5
    ln -sfn "$choice" "$lock_image"
}

# --- BAR SWITCHER FUNCTION ---
apply_bar() {
    local quickshell_dir="$HOME/.config/quickshell/qubar"
    local quickshell_target="$quickshell_dir/shell.qml"
    local options="Float\nModern\nN2\nNormal\nNotch\nPill\nSimp"
    local choice
    local source_file

    # Show Rofi Menu
    choice=$(echo -e "$options" | rofi -dmenu -i -theme "$SWITCHER_THEME" -p "Select Bar:")

    # If nothing is selected, exit this function
    [ -n "$choice" ] || return 1

    # Define the updated source file path (pointed to the new QuickShell directory)
    source_file="$HOME/.config/quickshell/bar/$choice/shell.qml"

    # Check if the chosen source file actually exists and copy it
    if [ -f "$source_file" ]; then
        mkdir -p "$quickshell_dir"
        cp "$source_file" "$quickshell_target"
    fi
}

# --- BAR LAYOUT SWITCHER FUNCTION (Bar / OSD) ---
apply_barlayout() {
    local quickshell_dir="$HOME/.config/quickshell"
    local quickshell_target="$quickshell_dir/reload.sh"
    local options="Bar\nOSD"
    local choice
    local source_file

    choice=$(echo -e "$options" | rofi -dmenu -i -theme "$SWITCHER_THEME" -p "Select Layout:")

    [ -n "$choice" ] || return 1

    source_file="$HOME/.config/quickshell/switch/$choice/reload.sh"

    if [ -f "$source_file" ]; then
        mkdir -p "$quickshell_dir"
        cp "$source_file" "$quickshell_target"
        chmod +x "$quickshell_target"
    fi
    
    # Safely restart Quickshell without crashing the script
    killall quickshell 2>/dev/null || true
    bash "$quickshell_target" & disown
}

# --- MAIN MENU EXECUTION ---
# Added 'Bar Layout' into the main menu selection
mode=$(printf "Theme\nWallpaper\nBar Style\nBar Layout" | rofi -dmenu -i -theme "$SWITCHER_THEME" -p "Action:")
[ -n "$mode" ] || exit 0

case "$mode" in
    Theme) apply_theme ;;
    Wallpaper) apply_wallpaper ;;
    "Bar Style") apply_bar ;;
    "Bar Layout") apply_barlayout ;;
esac
