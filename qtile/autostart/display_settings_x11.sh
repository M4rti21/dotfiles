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
xrandr --output DP-0 --primary \
              --mode 1920x1080 \
              --pos 1080x420 \
              --rotate normal \
              --rate 390 \
       --output DP-3 \
              --mode 1920x1080 \
              --pos 3000x420 \
              --rotate normal \
              --rate 60 \
       --output DP-5 \
              --mode 1920x1080 \
              --pos 0x0 \
              --rotate left \
              --rate 60 \
