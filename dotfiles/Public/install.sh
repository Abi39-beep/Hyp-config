#!/usr/bin/env bash

# install.sh - Arch Linux package installer for Hyprland setup
# Run with: chmod +x install.sh && ./install.sh
# Assumes yay AUR helper is installed [cite:2]

set -euo pipefail

echo "Updating Arch Linux system..."
sudo pacman -Syu --noconfirm

echo "Installing official repo packages..."
sudo pacman -S --needed --noconfirm \
    galculator \
    ristretto \
    rofi \
    hyprlock \
    hypridle \
    yazi \
    git \
    curl \
    nvim \
    otf-geist-mono-nerd \
    ttf-jetbrains-mono-nerd \
    nwg-look [web:8][web:9][web:10][web:12][web:13][web:14][web:15][web:16][web:17]

echo "Installing AUR packages (requires yay)..."
yay -S --needed --noconfirm \
    paper-icon-theme-git \
    hyprshot-git [web:7][web:11]

echo "Installation complete!"
echo "Refresh fonts: fc-cache -fv"
echo "Re-login or restart Hyprland to apply icons/fonts."
