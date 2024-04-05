# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source ~/dotfiles/config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/config/zsh/zsh-git-prompt/zshrc.sh

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Find and set branch name var if in git repository.
function git_branch_name()
{
  branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
  if [[ $branch == "" ]];
  then
    :
  else
    echo ' %F{blue}git:(%F{red}'$branch'%F{blue})'
  fi
}

# Enable substitution in the prompt.
setopt prompt_subst

# Prompt
PROMPT='%F{green}%1~$(git_branch_name) %F{yellow}➜ '
# PROMPT='%B%m%~%b$(git_super_status) %# '

function tmux_sessionizer() { 
    sh ~/dotfiles/scripts/tmux-sessionizer.sh
}

# Define a widget called "run_info", mapped to our function above.
zle -N tmux_sessionizer

# Bind it to ESC-i.
bindkey '^f' tmux_sessionizer

# Aliases
alias ls="exa --long --icons --group-directories-first"
alias la="exa --long --icons --group-directories-first --all"
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
