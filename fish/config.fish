if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

alias ls="exa --all --long --icons --group-directories-first"
alias update="echo 'pacman' && sudo pacman -Syu && echo 'aur' && yay -Syu && echo 'flatpak' && flatpak update"
