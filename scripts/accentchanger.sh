#!/bin/bash

if [ $# -eq 1 ]; then
    # gtk theme
    sed -i "/@define-color ac/s/#.*;/#$1;/" ~/dotfiles/themes/adw-gtk3-custom/gtk-*/gtk*.css
    # hyprland
    sed -i "/col.active_border = rgb/s/(.*/($1)/" ~/dotfiles/config/hypr/hyprland/theme.conf
    # tofi
    sed -i "/selection-background = /s/#.*/#$1/" ~/dotfiles/config/tofi/config

    killall waybar 
    hyprctl dispatch exec waybar > /dev/null
fi
