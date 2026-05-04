#!/usr/bin/env bash

# ----- Paths -----
ROFI_THEME="$HOME/.config/rofi/switcher.rasi"
QUICKSHELL_DIR="$HOME/.config/quickshell/learn"
QUICKSHELL_TARGET="$QUICKSHELL_DIR/shell.qml"

# ----- Rofi Menu -----
# Define the layout options
OPTIONS="Float\nModern\nNormal"

# Pipe options into rofi and wait for the user selection
CHOICE=$(echo -e "$OPTIONS" | rofi -dmenu -i -theme "$ROFI_THEME" -p "Select Bar:")

# If the user presses Escape or closes the menu, exit the script
if [ -z "$CHOICE" ]; then
    exit 0
fi

# ----- Copy File -----
# Define where to copy from based on the new central bar directory
SOURCE_FILE="$HOME/.config/color-scheme/bar/$CHOICE/shell.qml"

# Check if the chosen source file actually exists
if [ -f "$SOURCE_FILE" ]; then
    # Ensure the destination directory exists
    mkdir -p "$QUICKSHELL_DIR"
    
    # Copy the file
    cp "$SOURCE_FILE" "$QUICKSHELL_TARGET"
fi
