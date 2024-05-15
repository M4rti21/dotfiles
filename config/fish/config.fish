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
export GOPATH="$HOME/.local/share/go"
export __GL_SHADER_DISK_CACHE_PATH="$HOME/.local/share/nv"
export NUGET_PACKAGES="$HOME/.local/share/nuget"
export CARGO_HOME="$HOME/.local/share/cargo"

# do this to make sure that the path is set correctly
export ANDROID_HOME="/opt/android-sdk"
export ANDROID_SDK_ROOT="/opt/android-sdk"

alias rm="trash-put"
alias rmls="trash-list"
alias fm="joshuto"
alias ls="eza --long --icons --group-directories-first"
alias la="eza --long --icons --group-directories-first --all"
alias nf="fastfetch"
alias vim="nvim"
alias t="tmux"
alias ta="tmux a"
alias tn="tmux new -s"
alias tk="tmux kill-session -t"
alias tls="tmux ls"
alias tat="tmux a -t"
