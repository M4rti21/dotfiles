# AUTO LOGIN
if [[ "$(tty)" = "/dev/tty1" ]]; then
    Hyprland &> /dev/null
fi
