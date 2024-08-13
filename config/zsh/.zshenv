# PATH
export PATH=/usr/sbin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/dotfiles/bin:$PATH
export PATH=$HOME/dotfiles/scripts:$PATH
export PATH=$HOME/.local/share/cargo/bin:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH="$BUN_INSTALL/bin:$PATH"

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
export IBM_TELEMETRY_DISABLED=true  # lol

# XDG-CLEANUP
export BUN_INSTALL="$HOME/.local/share/bun" 
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"
export GOPATH="$XDG_DATA_HOME/go"
export DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export HISTFILE="$XDG_STATE_HOME/bash/history"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export NUGET_PACKAGES="$XDG_DATA_HOME/nuget"
export WGATRC="$XDG_CONFIG_HOME/wget/wgetrc"
export WINEPREFIX="$XDG_DATA_HOME/wine"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export __GL_SHADER_DISK_CACHE_PATH="$XDG_DATA_HOME/nv"
