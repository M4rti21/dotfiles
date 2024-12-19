#!/bin/sh

#    qtile display settings script by:
#
#    ███╗   ███╗██╗  ██╗██████╗ ████████╗██╗
#    ████╗ ████║██║  ██║██╔══██╗╚══██╔══╝██║
#    ██╔████╔██║███████║██████╔╝   ██║   ██║
#    ██║╚██╔╝██║╚════██║██╔══██╗   ██║   ██║
#    ██║ ╚═╝ ██║     ██║██║  ██║   ██║   ██║
#    ╚═╝     ╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝
#
#   github repo: https://github.com/M4rti21/dotfiles

# SCREEN POSITIONS
wlr-randr \
    --output HDMI-A-2 \
    --mode 1920x1080 \
    --pos 0x0 \
    --transform 90 \
    --output DP-1 --primary \
    --mode 1920x1080@359.747986 \
    --pos 1080x420 \
    --adaptative-sync enabled \
    --output DP-2 \
    --mode 1920x1080 \
    --pos 3000x420
