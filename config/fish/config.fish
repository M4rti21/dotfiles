if status is-interactive
    # Commands to run in interactive sessions can go here
end

function tmux-sessionizer
    sh ~/dotfiles/scripts/tmux-sessionizer.sh
end

set -U fish_greeting

# PATH
set -x  PATH $PATH
set -gx PATH /usr/bin         $PATH
set -gx PATH /usr/sbin        $PATH
set -gx PATH /usr/local/bin   $PATH
set -gx PATH /usr/local/sbin  $PATH
set -gx PATH $HOME/.local/bin $PATH

bind \cf 'tmux-sessionizer'

# VARIABLES
export EDITOR=nvim
export BROWSER=firefox

# do this to make sure that the path is set correctly
export ANDROID_HOME="$HOME/.android-sdk"
export ANDROID_SDK_ROOT="$HOME/.android-sdk"

alias rm="trash-put"
alias rmls="trash-list"
alias fm="joshuto"
alias ls="eza --long --icons --group-directories-first"
alias la="eza --long --icons --group-directories-first --all"
alias update="paru -Syu && echo 'flatpak' && flatpak update"
alias purge="sudo pacman -Qdtq | sudo pacman -Rns - && flatpak uninstall --unused -y"
alias nf="fastfetch"
alias vim="nvim"
alias t="tmux"
alias ta="tmux a"
alias tn="tmux new -s"
alias tk="tmux kill-session -t"
alias tls="tmux ls"
alias tat="tmux a -t"
alias s="kitten ssh"
