# PATH
export PATH=/usr/sbin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH

# XDG_DIRS
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# ENV
export DEFAULT_TERM=foot
export TERM=foot
export EDITOR=nvim
export BROWSER=firefox

# XDG-NINJA
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export HISTFILE="$XDG_STATE_HOME/bash/history"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GOPATH="$XDG_DATA_HOME/go"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export NUGET_PACKAGES="$XDG_DATA_HOME/nuget"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_DATA_HOME/nv"
export WINEPREFIX="$XDG_DATA_HOME/wine"

# ALIAS
# system
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias restart="sudo systemctl restart"
alias rm="trash-put"
alias rmls="trash-list"
alias ls="eza --long --icons --group-directories-first"
alias la="eza --long --icons --group-directories-first --all"
alias wget="wget --hsts-file=$XDG_DATA_HOME/wget-hsts"

alias update="paru -Syu && flatpak update"
alias purge="paru -Qdtq | paru -R - && flatpak uninstall --unused"

# programs
alias nf="fastfetch"
alias vim="nvim"
alias t="tmux"
alias ta="tmux a"
alias tn="tmux new -s"
alias tk="tmux kill-session -t"
alias tls="tmux ls"
alias tat="tmux a -t"

# ZINIT
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# HISTORY
HISTFILE=$XDG_CACHE_HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt HIST_IGNORE_ALL_DUPS
setopt histignorealldups

# PLUGINS
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light joshskidmore/zsh-fzf-history-search

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"

zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload 'history_substring_search_config'
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# PROMPT
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' %F{blue}%s:(%f%F{red}%b%f%F{blue})%f'

setopt PROMPT_SUBST
PROMPT='%F{green}%~%f${vcs_info_msg_0_} %F{yellow}$%f '

tmux-sessionizer() $HOME/dotfiles/scripts/tmux-sessionizer.sh
zle -N tmux-sessionizer
bindkey -s '^F' tmux-sessionizer^M

# AUTO LOGIN
if [[ -o login ]]; then
    if [[ "$(tty)" = "/dev/tty1" ]]; then
        Hyprland &> /dev/null
    fi
fi
