function tmux-sessionizer
    sh ~/dotfiles/scripts/tmux-sessionizer.sh
end

set -U fish_greeting

# PATH
set -x  PATH $PATH
set -gx PATH /usr/sbin        $PATH
set -gx PATH /usr/bin         $PATH
set -gx PATH /usr/local/sbin  $PATH
set -gx PATH /usr/local/bin   $PATH
set -gx PATH $HOME/.local/bin $PATH

bind \cf 'tmux-sessionizer'

# VARIABLES
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Home paths
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons

export HISTFILE="$XDG_STATE_HOME/bash/history"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GOPATH="$XDG_DATA_HOME/go"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority

alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
# export MYVIMRC="$XDG_CONFIG_HOME/.vimrc"
# export VIMINIT="source $MYVIMRC"

export EDITOR=nvim
export BROWSER=firefox
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NUGET_PACKAGES="$XDG_DATA_HOME/nuget"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_DATA_HOME/nv"

# do this to make sure that the path is set correctly
alias rm="trash-put"
alias rmls="trash-list"
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
