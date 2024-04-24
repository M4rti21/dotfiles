#!/usr/bin/env bash

directories=(
    "$HOME/Projects"
    "$HOME/Projects/ies"
    "$HOME/Projects/ies/m7"
    "$HOME/Projects/ies/m8"
    "$HOME/Projects/ies/m9"
    "$HOME/Projects/wysi"
    "$HOME/Documents"
    "$HOME/dotfiles"
    "$HOME/dotfiles/config"
    "$HOME/dotfiles/scripts"
    "$HOME"
)

if [[ $# -eq 1 ]]; then
    dir=$1
else
    dir=$(find "${directories[@]}" -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $dir ]]; then
    exit 0
fi

session=$(basename "$dir" | tr . _)
tmux_running=$(pgrep tmux)
inside_tmux=$(test "$TERM_PROGRAM" = 'tmux' && echo 'true' || echo 'false')

# Check if session already exists, if yes, attach to it
if tmux has-session -t=$session 2>/dev/null; then

    # If inside a tmux session, switch to the selected session
    if [[ $inside_tmux == 'true' ]]; then
        tmux switch-client -t $session
        exit 0
    fi
    # If not inside a tmux session, attach to the selected session
    tmux attach-session -t $session
    exit 0
fi

# If tmux does not have a session with the selected name, create one
if [[ $inside_tmux == 'true' ]]; then
    tmux new-session -d -s $session -c $dir
else
    tmux new-session -d -s $session -c $dir
fi

if [[ $dir == "$HOME/Projects"* ]]; then
    tmux rename-window -t $session:0 nvim
    tmux send-keys -t $session:0 "nvim" Enter
    tmux new-window -t $session:1 -n term -c $dir
    # tmux split-window -v -c "#{pane_current_path}"
    tmux new-window -t $session:2 -n git -c $dir
    tmux send-keys -t $session:2 "git status" Enter
    tmux select-window -t $session:0
fi

if [[ $inside_tmux == 'true' ]]; then
    tmux switch-client -t $session
else
    tmux attach-session -t $session
fi
