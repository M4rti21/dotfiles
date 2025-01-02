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
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light joshskidmore/zsh-fzf-history-search

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#949494"

zinit load zsh-users/zsh-history-substring-search
zinit ice wait atload 'history_substring_search_config'
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# I need this for some reason /shrug
autoload -Uz compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'm:{a-zA-Z}={A-Za-z} l:|=* r:|=*'
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# PROMPT
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' %F{blue}%s:(%f%F{red}%b%f%F{blue})%f'

setopt PROMPT_SUBST
PROMPT='%F{green}%~%f${vcs_info_msg_0_} %F{yellow}$%f '

bindkey -s '^F' tmux-sessionizer^M

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char

# IMPORTS
source ~/.config/zsh/.zshalias
source ~/.config/zsh/.zsh-priv-env

start () { 
    service=$1
    if [ $service = "dwl" ]; then
        dwl_start
    elif [ $service = "nvm" ]; then
        source /usr/share/nvm/init-nvm.sh
    elif [ $service = "docker" ]; then
        sudo dinitctl start dockerd
    elif [ $service = "bluetooth" ]; then
        sudo dinitctl start bluetoothd
    elif [ $service = "python" ]; then
        source "$HOME/Projects/Personal/python/venv/bin/activate"
    elif [ $service = "waydroid" ]; then
        sudo waydroid container start &
        waydroid session start &
    else
        echo "no service with name $service"
    fi
}

stop () { 
    service=$1
    if [ $service = "dwl" ]; then
        killall dwl
    elif [ $service = "docker" ]; then
        sudo dinitctl stop dockerd
    elif [ $service = "bluetooth" ]; then
        sudo dinitctl stop bluetoothd
    elif [ $service = "python" ]; then
        deactivate
    elif [ $service = "waydroid" ]; then
        waydroid session stop &
        sudo waydroid container stop &
    else
        echo "no service with name $service"
    fi
}
