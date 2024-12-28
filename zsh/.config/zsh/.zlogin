# AUTO LOGIN
if [[ "$(tty)" = "/dev/tty1" ]]; then
    dwl_start
elif [[ "$(tty)" = "/dev/tty2" ]]; then
    startx
fi
