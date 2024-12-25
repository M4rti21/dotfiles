export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/dbus-session
export XDG_RUNTIME_DIR=/run/user/1000

exec dinit >> ~/.local/share/dinit/dinit.log &
