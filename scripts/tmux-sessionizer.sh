#!/usr/bin/env bash

directories=(
    "$HOME/Projects"
    "$HOME/Projects/wysi"
    "$HOME/Documents"
    "$HOME"
)

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find "${directories[@]}" -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)
inside_tmux=$(test "$TERM_PROGRAM" = 'tmux' && echo 'true' || echo 'false')

# Check if session already exists, if yes, attach to it
if tmux has-session -t=$selected_name 2>/dev/null; then

    # If inside a tmux session, switch to the selected session
    if [[ $inside_tmux == 'true' ]]; then
        tmux switch-client -t $selected_name
        exit 0
    fi
    # If not inside a tmux session, attach to the selected session
    tmux attach-session -t $selected_name
    exit 0
fi
# If tmux does not have a session with the selected name, create one
if [[ $inside_tmux == 'true' ]]; then
    tmux new-session -d -s $selected_name -c $selected
    tmux switch-client -t $selected_name
else
    tmux new-session -s $selected_name -c $selected
fi
