#!/bin/sh

mkdir -p "$HOME/Documents"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/Games"
mkdir -p "$HOME/Pictures"
mkdir -p "$HOME/Pictures/screenshots"
mkdir -p "$HOME/Projects"
mkdir -p "$HOME/Videos"
mkdir -p "$HOME/.local/share/gnupg"
mkdir -p "$HOME/.local/bin"

# CHECK IF PARU IS INSTALLED
if ! command -v paru >/dev/null 2>&1
then
    echo "paru is not installed, installing..."
    if git clone https://aur.archlinux.org/paru ~/Downloads/paru; then
        if cd ~/Downloads/paru; then
            makepkg -si
            cd "$start_dir"
        else
            echo "Failed to change directory to ~/Downloads/paru"
            exit 1
        fi
    else
        echo "Failed to clone paru repository"
        exit 1
    fi
fi

echo "\nUpdating system...\n"
paru -Syu

# ENABLE MULTILIB
multilib_pattern="^\[multilib\]$"
include_pattern="^Include = /etc/pacman.d/mirrorlist$"

# Check if the exact lines exist in /etc/pacman.conf
if grep -Fxq "[multilib]" /etc/pacman.conf && grep -Fxq "Include = /etc/pacman.d/mirrorlist" /etc/pacman.conf; then
    echo "Both [multilib] and Include = /etc/pacman.d/mirrorlist are present in /etc/pacman.conf."
else
    echo "Required lines are not present in /etc/pacman.conf. Appending them to the end of the file."

    # Use sudo to append the exact lines at the end of /etc/pacman.conf
    sudo sh -c '{
        echo "[multilib]"
        echo "Include = /etc/pacman.d/mirrorlist"
    } >> /etc/pacman.conf'
    
    echo "Updating repositories..."
    paru -Syu
fi
