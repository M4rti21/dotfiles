#!/bin/sh

start_dir=$(pwd)
script_dir="$(cd "$(dirname "$0")" && pwd)"

create_symlink() {
    src=$1
    tgt=$2
    current_date=$(date +"%Y%m%d_%H%M%S")  # Format the current date

    # Check if source directory exists
    if [ -d "$src" ]; then
        # Create target directory if it doesn't exist
        if [ -e "$tgt" ]; then
            # Rename existing directory
            mv "$tgt" "${tgt}_bak_$current_date"
            echo "Renamed existing directory: $tgt to ${tgt}_bak_$current_date"
        fi
        
        mkdir -p "$tgt"  # Create the target directory
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

packages=""

tm=false
ask "Do you want the the terminal envoirment?" tm
if "$tm"; then
    packages+="$(cat "$script_dir/packages/terminal.txt")"

    sudo ln -s /usr/bin/foot /usr/bin/xdg-terminal-exec                         # Set foot as xdg exec terminal
    chsh -s /usr/bin/zsh                                                        # Change default shell to zsh

    zshexport='export ZDOTDIR="$HOME/.config/zsh"'
    if grep -Fxq "$zshexport" /etc/zsh/zshenv; then
        echo "export already done"
    else
        echo "/etc/zsh/zshenv does not point to home/.config/zsh"
        sudo mkdir -p /etc/zsh
        sudo sh -c "echo '$zshexport' >> /etc/zsh/zshenv"
    fi
fi

ad=false
ask "Do you want the audio stack?" ad
if "$ad"; then
    packages+="$(cat "$script_dir/packages/audio.txt")"
fi

hr=false
ask "Do you want hyprland?" hr
if "$hr"; then
    packages+="$(cat "$script_dir/packages/hyprland.txt")"
fi

bt=false
ask "Do you want Bluetooth support?" bt
if "$bt"; then
    packages+="$(cat "$script_dir/packages/bluetooth.txt")"
fi

lk=false
ask "Do you want to create all the symlinks?" lk

fp=false
ask "Do you want to setup flatpak?" fp
if "$fp"; then
    packages+=" flatpak "
fi

fa=false
ask "Do you want to install all flatpak apps?" fa

ai=false
ask "Do you want AppImage support?" ai
if "$ai"; then
    packages+=" fuse2 "
fi

ex=false
ask "Do you want to install all extra apps?" ex
if "$ex"; then
    packages+="$(cat "$script_dir/packages/extras.txt")"
fi

vm=false
ask "Do you want QEMU/KVM support?" vm
if "$vm"; then
    packages+="$(cat "$script_dir/packages/virt.txt")"
fi

packages=$(echo "$packages" | xargs)

if [ -n "$packages" ]; then
    echo "Installing packages: $packages"
    sudo paru -S --needed $packages
fi

if "$fp"; then
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

if "$fa"; then
    flatpak install $(cat "$script_dir/packages/flatpaks.txt" | xargs)
fi

if $lk; then
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
fi

