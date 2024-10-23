#!/bin/bash
# Get the connected monitors
monitors=( $(hyprctl monitors | grep -oP 'Monitor \K[\w-]+') )

# Assign monitor names from environment variables
specified_monitors=("$MONITOR_PRIMARY" "$MONITOR_SECONDARY" "$MONITOR_TERTIARY")

# Filter only connected specified monitors
connected_monitors=()
for monitor in "${specified_monitors[@]}"; do
    if [[ " ${monitors[*]} " =~ " $monitor " ]]; then
        connected_monitors+=("$monitor")
    fi
done

# Use connected monitors or default to the first available ones
if [ ${#connected_monitors[@]} -eq 0 ]; then
    notify-send "No specified monitors are connected. Defaulting to the first connected monitor."
    connected_monitors=("${monitors[@]:0:1}")
fi

# Function to set workspace properties and move workspace to monitor
set_workspace() {
    local workspace=$1
    local monitor=$2
    hyprctl keyword workspace "$workspace",monitor:"$monitor",persistent:true
    hyprctl dispatch moveworkspacetomonitor "$workspace" "$monitor"
}

# Bind workspaces based on the number of connected monitors
case ${#connected_monitors[@]} in
    1)
        for i in {1..9}; do
            set_workspace $i "${connected_monitors[0]}"
        done
        ;;
    2)
        for i in {1..5}; do
            set_workspace $i "${connected_monitors[0]}"
        done
        for i in {6..9}; do
            set_workspace $i "${connected_monitors[1]}"
        done
        ;;
    3)
        for i in {1..5}; do
            set_workspace $i "${connected_monitors[0]}"
        done
        for i in {6..8}; do
            set_workspace $i "${connected_monitors[1]}"
        done
        set_workspace 9 "${connected_monitors[2]}"
        ;;
esac

notify-send "Workspaces have been bound to the connected monitors."
