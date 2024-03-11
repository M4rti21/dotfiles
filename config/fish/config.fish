if status is-interactive
    # Commands to run in interactive sessions can go here
end

function tmux-sessionizer
    sh ~/dotfiles/scripts/tmux-sessionizer.sh
end

set -U fish_greeting

bind \cf 'tmux-sessionizer'

# do this to make sure that the path is set correctly
export ANDROID_HOME="$HOME/.android-sdk"
export ANDROID_SDK_ROOT="$HOME/.android-sdk"


alias c="clear"
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
alias tk="tmux kill-session -t"
alias tls="tmux ls"
alias tat="tmux a -t"

