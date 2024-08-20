#!/bin/sh

windows_in() {
    hyprctl clients -j | jq ".[] | select(.workspace.name == \"special:$1\" )"
}

toggle_scratchpad() {
    workspace_name="$1"
    cmd="$2"

    windows=$( windows_in "$workspace_name" )
    if [ -z "$windows" ]; then
        hyprctl dispatch "exec [workspace special:$workspace_name] $cmd"
    else
        hyprctl dispatch togglespecialworkspace "$workspace_name"
    fi
}

if [ "$1" = "volume" ]; then
    toggle_scratchpad "volume" "flatpak run com.saivert.pwvucontrol"
elif [ "$1" = "password" ]; then
    toggle_scratchpad "password" 'flatpak run com.bitwarden.desktop'
elif [ "$1" = "music" ]; then
    toggle_scratchpad "music" "flatpak run com.github.KRTirtho.Spotube"
fi
