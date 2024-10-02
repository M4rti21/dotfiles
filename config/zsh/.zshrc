# ALIAS
# system
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias restart="sudo systemctl restart"
alias rm="trash-put"
alias rmls="trash-list"
alias ls="eza --long --icons --group-directories-first"
alias la="eza --long --icons --group-directories-first --all"
alias tree="eza --tree --icons --all"

alias update="paru -Syu && flatpak update"
alias purge="paru -Qdtq | paru -R - && flatpak uninstall --unused"

# programs
alias nf="fastfetch"
alias vim="nvim"
alias t="tmux"
alias tks="tmux kill-session -t"
alias tls="tmux ls"

lfcd () { cd "$(command lf -print-last-dir "$@")" }

alias lf="lfcd"

# common typos
alias gti="git"
alias exti="exit"

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

declare -A pomo_options
pomo_options["work"]="45"
pomo_options["break"]="10"
pomo_options["test"]="1"

pomodoro () {
  if [ -n "$1" -a -n "${pomo_options["$1"]}" ]; then
  val=$1
  echo $val | lolcat
  timer ${pomo_options["$val"]}m
  notify-send "'$val' session done"
  fi
}

alias wo="pomodoro 'work'"
alias br="pomodoro 'break'"
alias te="pomodoro 'test'"

# bun completions
[ -s "/home/m4rti/.local/share/bun/_bun" ] && source "/home/m4rti/.local/share/bun/_bun"
