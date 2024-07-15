# AUTO LOGIN
if [[ "$(tty)" = "/dev/tty1" ]]; then
    Hyprland
elif [[ "$(tty)" = "/dev/tty2" ]]; then
    startx
fi
