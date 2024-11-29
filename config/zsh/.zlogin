# AUTO LOGIN
if [[ "$(tty)" = "/dev/tty1" ]]; then
    dwl_start
elif [[ "$(tty)" = "/dev/tty2" ]]; then
    Hyprland
elif [[ "$(tty)" = "/dev/tty3" ]]; then
    startx
fi
