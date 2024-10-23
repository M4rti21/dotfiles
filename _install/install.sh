#!/bin/sh

start_dir=$(pwd)
script_dir="$(cd "$(dirname "$0")" && pwd)"

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
if ! command -v paru >/dev/null 2>&1; then
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

create_symlink() {
    src=$1
    tgt=$2
    current_date=$(date +"%Y%m%d_%H%M%S") # Format the current date

    # Check if source directory exists
    if [ -d "$src" ]; then
        # Create target directory if it doesn't exist
        if [ -e "$tgt" ]; then
            # Rename existing directory
            mv "$tgt" "${tgt}_bak_$current_date"
            echo "Renamed existing directory: $tgt to ${tgt}_bak_$current_date"
        fi

        mkdir -p "$tgt" # Create the target directory
        link_path="$tgt/$(basename "$src")"

        # Create the symlink if it doesn't already exist
        if [ ! -e "$link_path" ]; then
            ln -s "$src" "$link_path"
            echo "Created symlink: $link_path -> $src"
        else
            echo "Symlink already exists: $link_path"
        fi
    else
        echo "Source directory does not exist: $src"
    fi
}

ask() {
    read -p "$1 [y/N]: " res
    res=$(echo "$res" | tr '[:upper:]' '[:lower:]')
    local -n ref=$2
    ref=false
    if [ "$res" = "y" ]; then
        ref=true
    else
        ref=false
    fi
}

packages=""

read -p "What GPU do you have? [1] AMD / [2] Nvidia / [3] Intel / [0] None: " gpu
case "$gpu" in
1)
    echo "You have selected AMD GPU."
    packages+="$(cat "$script_dir/packages/gpu-amd.txt")"
    ;;
2)
    echo "You have selected Nvidia GPU."
    packages+="$(cat "$script_dir/packages/gpu-nvidia.txt")"
    ;;
3)
    echo "You have selected Intel GPU."
    packages+="$(cat "$script_dir/packages/gpu-intel.txt")"
    ;;
*)
    echo "No GPU selected, skiping drivers..."
    ;;
esac

packages+="$(cat "$script_dir/packages/audio.txt")"
packages+="$(cat "$script_dir/packages/terminal.txt")"
packages+="$(cat "$script_dir/packages/coding.txt")"
packages+="$(cat "$script_dir/packages/hyprland.txt")"
packages+="$(cat "$script_dir/packages/bluetooth.txt")"
packages+=" flatpak "
packages+=" fuse2 "
packages+="$(cat "$script_dir/packages/extras.txt")"

vm=false
ask "Do you want QEMU/KVM support?" vm
if "$vm"; then
    packages+="$(cat "$script_dir/packages/virt.txt")"
fi

sudo ln -s /usr/bin/foot /usr/bin/xdg-terminal-exec # Set foot as xdg exec terminal
chsh -s /usr/bin/zsh                                # Change default shell to zsh

zshexport='export ZDOTDIR="$HOME/.config/zsh"'
if grep -Fxq "$zshexport" /etc/zsh/zshenv; then
    echo "export already done"
else
    echo "/etc/zsh/zshenv does not point to home/.config/zsh"
    sudo mkdir -p /etc/zsh
    sudo sh -c "echo '$zshexport' >> /etc/zsh/zshenv"
fi

if [ -n "$packages" ]; then
    echo "Installing packages: $packages"
    sudo paru -S --needed $packages
fi

flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install $(cat "$script_dir/packages/flatpaks.txt" | xargs)

target_dir="$HOME/.config"
mkdir -p "$target_dir"
# Loop through each item in the $start_dir/config directory
for dir in "$start_dir/config"/*; do
    dir_name=$(basename "$dir")
    symlink_path="$target_dir/$dir_name"
    if [ ! -e "$symlink_path" ]; then
        ln -s "$dir" "$symlink_path"
        echo "Created symlink: $symlink_path -> $dir"
    else
        echo "Symlink already exists: $symlink_path"
    fi
done

create_symlink "$start_dir/icons" "$HOME/.local/share"
create_symlink "$start_dir/icons" "$HOME/.icons"
create_symlink "$start_dir/themes" "$HOME/.local/share"
create_symlink "$start_dir/themes" "$HOME/.themes"
create_symlink "$start_dir/fonts" "$HOME/.local/share"
create_symlink "$start_dir/wallpapers" "$HOME/Pictures/wallpapers"

echo "All done!"
