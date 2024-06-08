ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

export PATH=/usr/sbin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# VARIABLES
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

export DEFAULT_TERM=foot
export TERM=$DEFAULT_TERM

# Home paths
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons

export HISTFILE="$XDG_STATE_HOME/bash/history"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GOPATH="$XDG_DATA_HOME/go"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# export MYVIMRC="$XDG_CONFIG_HOME/.vimrc"
# export VIMINIT="source $MYVIMRC"

export EDITOR=nvim
export BROWSER=firefox
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NUGET_PACKAGES="$XDG_DATA_HOME/nuget"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_DATA_HOME/nv"

alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"
# do this to make sure that the path is set correctly
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias restart="sudo systemctl restart"

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

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-history-substring-search
zinit load agkozak/agkozak-zsh-prompt

if [[ -o login ]]; then
    if [[ "$(tty)" = "/dev/tty1" ]]; then
        Hyprland &> /dev/null
    fi
fi
