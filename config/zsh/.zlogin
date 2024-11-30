# AUTO LOGIN
if [[ "$(tty)" = "/dev/tty1" ]]; then
    Hyprland &> /dev/null
elif [[ "$(tty)" = "/dev/tty2" ]]; then
    dwl
elif [[ "$(tty)" = "/dev/tty3" ]]; then
    startx
fi
