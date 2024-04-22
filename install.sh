#!/bin/bash
## update system
sudo pacman -Syu
## necessary packages
sudo pacman -S fish exa wofi alacritty alsa-utils polkit-gnome gnome-keyring gvfs pavucontrol dunst git
## optional packages
sudo pacman -S alacritty firefox fastfetch thunar thunar-archive-plugin xarchiver tmux neovim btop

echo "hello"
echo "hellowo"
