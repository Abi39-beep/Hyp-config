#!/usr/bin/env bash

# Paths
THEME_DIR="$HOME/.config/color-scheme"
CONF_DIR="$HOME/.config"

# 1. Select Theme using the custom switcher layout
# Note the -theme flag pointing to our new file
SELECTED_THEME=$(ls -d "$THEME_DIR"/*/ | xargs -n 1 basename | rofi -dmenu -p "Theme:" -theme "$CONF_DIR/rofi/switcher.rasi")

# Exit if nothing is selected (Esc pressed)
if [ -z "$SELECTED_THEME" ]; then
    exit 1
fi

# 2. Update the color link files
# Rofi Color (Points to the specific theme file)
echo "@import \"$THEME_DIR/$SELECTED_THEME/rofi/$SELECTED_THEME.rasi\"" > "$CONF_DIR/rofi/color.rasi"

# Kitty
echo "include $THEME_DIR/$SELECTED_THEME/kitty/$SELECTED_THEME.conf" > "$CONF_DIR/kitty/color.conf"

# Waybar
echo "@import \"$THEME_DIR/$SELECTED_THEME/waybar/$SELECTED_THEME.css\";" > "$CONF_DIR/waybar/color.css"

# SwayNC
echo "@import \"$THEME_DIR/$SELECTED_THEME/swaync/$SELECTED_THEME.css\";" > "$CONF_DIR/swaync/color.css"

# Hyprlock
echo "source = $THEME_DIR/$SELECTED_THEME/hyprlock/$SELECTED_THEME.conf" > "$CONF_DIR/hypr/color.conf"

# Foot
echo "include=$THEME_DIR/$SELECTED_THEME/foot/$SELECTED_THEME.ini" > "$CONF_DIR/foot/color.ini"


# 3. Reload Applications
# Waybar reload (Restarts if it was closed)
if pgrep -x "waybar" > /dev/null; then
    killall -SIGUSR2 waybar
else
    waybar &
fi

# Reload SwayNC
swaync-client -rs

# Reload Kitty
killall -USR1 kitty

# Reload Hyprland
hyprctl reload

notify-send "Theme Switcher" "Applied $SELECTED_THEME theme"