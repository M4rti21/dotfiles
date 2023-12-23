#!/bin/sh

#   qtile autostart script by:
#   
#    ███╗   ███╗██╗  ██╗██████╗ ████████╗██╗
#    ████╗ ████║██║  ██║██╔══██╗╚══██╔══╝██║
#    ██╔████╔██║███████║██████╔╝   ██║   ██║
#    ██║╚██╔╝██║╚════██║██╔══██╗   ██║   ██║
#    ██║ ╚═╝ ██║     ██║██║  ██║   ██║   ██║
#    ╚═╝     ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝
#
#   github repo: https://github.com/M4rti21/dotfiles

# SERVICES
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# APPLICATIONS
dunst &                   # Notification daemon
nitrogen --restore &      # Wallpaper

otd-daemon &              # OpenTabletDriver
