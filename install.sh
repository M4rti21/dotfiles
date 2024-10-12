#!/bin/sh

start_dir=$(pwd)
mkdir -p "$HOME/Documents"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/Games"
mkdir -p "$HOME/Pictures"
mkdir -p "$HOME/Pictures/screenshots"
mkdir -p "$HOME/Projects"
mkdir -p "$HOME/Videos"
mkdir -p "$HOME/.local/share/gnupg"
mkdir -p "$HOME/.local/bin"

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

echo "\nInstalling audio stack...\n"

paru -S --needed pipewire pipewire-pulse pipewire-alsa wireplumber alsa-utils pavucontrol

echo "\nInstalling shell \n"

paru -S --needed zsh foot eza jq bat trash-cli tmux ffmpeg man lsof usbutils polkit-gnome wtype

# Set foot as xdg exec terminal
sudo ln -s /usr/bin/foot /usr/bin/xdg-terminal-exec

echo "\nChanging default shell to zsh"
chsh -s /usr/bin/zsh

zshexport='export ZDOTDIR="$HOME/.config/zsh"'

# Check if the exact line exists in /etc/zsh/zshenv
if grep -Fxq "$zshexport" /etc/zsh/zshenv; then
    echo "export already done"
else
    echo "/etc/zsh/zshenv does not point to home/.config/zsh"
    sudo mkdir -p /etc/zsh
    sudo sh -c "echo '$zshexport' >> /etc/zsh/zshenv"
fi

# Define the exact patterns to search for
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


# Prompt the user for their GPU type
read -p "What GPU do you have? [1] AMD / [2] Nvidia / [3] Intel / [0] None: " gpu

# Use a case statement to handle the user's choice
case "$gpu" in
    1)
        echo "You have selected AMD GPU."
        paru -S --needed rocm-smi-lib lib32-mesa vulkan-radeon lib32-vulkan-radeon vulkan-icd-loader lib32-vulkan-icd-loader
        ;;
    2)
        echo "You have selected Nvidia GPU."
        paru -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
        ;;
    3)
        echo "You have selected Intel GPU."
        paru -S --needed rocm-smi-lib lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader
        ;;
    *)
        echo "No GPU selected, skiping drivers..."
        ;;
esac

# Terminal utils
echo "\nInstalling terminal utils\n"
paru -S --needed btop fastfetch lf perl-file-mimeinfo ripdrag chafa zip unzip unrar tar p7zip imv mpv zathura zathura-pdf-poppler neovim vim ffmpegthumbnailer newsboat

# Desktop
echo "\nInstalling hyprland...\n"
paru -S --needed hyprland xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-user-dirs waybar hyprpaper tofi wl-gammarelay-rs wl-clipboard wl-clip-persist xclip cliphist

echo "\nInstalling costumization apps...\n"
paru -S --needed nwg-look qt5ct qt6ct

read -p "Do you want Flatpak support? [y/N] " flatpaks
flatpaks=$(echo "$flatpaks" | tr '[:upper:]' '[:lower:]')

if [ "$flatpaks" = "y" ]; then
    paru -S --needed flatpak
    flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
else
    echo "Skipping..."
fi

read -p "Do you want AppImage support? [y/N] " appimages
appimages=$(echo "$appimages" | tr '[:upper:]' '[:lower:]')

if [ "$appimages" = "y" ]; then
    paru -S --needed fuse2
else
    echo "Skipping..."
fi

read -p "Do you want snap support? [y/N] " snaps

echo "Just kidding..."

read -p "Do you want QEMU/KVM support? [y/N] " qemuvm
qemuvm=$(echo "$qemuvm" | tr '[:upper:]' '[:lower:]')

if [ "$qemuvm" = "y" ]; then
    paru -S --needed qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables swtmp
else
    echo "Skipping..."
fi

read -p "Do you want Bluetooth support? [y/N] " blue
blue=$(echo "$blue" | tr '[:upper:]' '[:lower:]')

if [ "$blue" = "y" ]; then
    paru -S --needed bluez bluetui
else
    echo "Skipping..."
fi

echo "Linking all configs..."

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

# Function to create symlink if it doesn't exist
create_symlink() {
    src=$1
    tgt=$2

    # Create the target directory if it doesn't exist
    mkdir -p "$tgt"

    # Create the symbolic link if it doesn't already exist
    if [ -d "$src" ]; then
        link_path="$tgt/$(basename "$src")"
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

# Create symlinks for icons, themes, and fonts
create_symlink "$start_dir/icons" "$HOME/.local/share"
create_symlink "$start_dir/icons" "$HOME/.icons"
create_symlink "$start_dir/themes" "$HOME/.local/share"
create_symlink "$start_dir/themes" "$HOME/.themes"
create_symlink "$start_dir/fonts" "$HOME/.local/share"
create_symlink "$start_dir/wallpapers" "$HOME/Pictures/wallpapers"

echo "Copying scripts"
git clone https://github.com/m4rti21/tmux-sessionizer ~/Projects/tmux-sessionizer
git clone https://github.com/m4rti21/ctpv ~/Projects/ctpv
git clone https://github.com/m4rti21/compi.nvim ~/Projects/compi.nvim
git clone https://github.com/m4rti21/acc ~/Projects/acc

create_symlink "$HOME/Projects/acc/acc" "$HOME/.local/bin"
create_symlink "$HOME/Projects/tmux-sessionizer/tmux-sessionizer" "$HOME/.local/bin"

cd "$HOME/Projects/ctpv"
make

create_symlink "$HOME/Projects/ctpv/ctpv" "$HOME/.local/bin"
create_symlink "$HOME/Projects/ctpv/ctpvclear" "$HOME/.local/bin"

cd "$start_dir"

echo "All done!"
