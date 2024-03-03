if status is-interactive
    # Commands to run in interactive sessions can go here
end

function tmux-sessionizer
    sh ~/dotfiles/scripts/tmux-sessionizer.sh
end

set -U fish_greeting

zoxide init fish | source

bind \cf 'tmux-sessionizer'

alias c="clear"
alias cd="z"
alias ls="exa --long --icons --group-directories-first"
alias la="exa --long --icons --group-directories-first --all"
alias update="echo 'pacman' && sudo pacman -Syu && echo 'aur' && yay -Syu && echo 'flatpak' && flatpak update"
alias purge="sudo pacman -Qdtq | sudo pacman -Rns - && flatpak uninstall --unused -y"
alias neofetch="fastfetch"
alias nf="fastfetch"
alias vim="nvim"
alias t="tmux"
alias ta="tmux a"
alias tn="tmux new -s"
alias tl="tmux ls"
alias tk="tmux kill-session -t"
alias tat="tmux a -t"

