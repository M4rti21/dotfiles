if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -U fish_greeting

zoxide init fish | source

alias ls="exa --all --long --icons --group-directories-first"
alias cd="z"
alias update="echo 'pacman' && sudo pacman -Syu && echo 'aur' && yay -Syu && echo 'flatpak' && flatpak update"
alias purge="sudo pacman -Qdtq | sudo pacman -Rns -"
alias nf="neofetch"
alias vim="nvim"
alias t="tmux"
alias ta="tmux a"
alias tat="tmux a -t"
