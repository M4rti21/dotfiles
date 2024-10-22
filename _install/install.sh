# Terminal utils
echo "\nInstalling terminal utils\n"
paru -S --needed 

# Desktop
echo "\nInstalling hyprland...\n"
paru -S --needed 

echo "\nInstalling costumization apps...\n"
paru -S --needed 

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
    paru -S --needed 
else
    echo "Skipping..."
fi

read -p "Do you want Bluetooth support? [y/N] " blue
blue=$(echo "$blue" | tr '[:upper:]' '[:lower:]')

if [ "$blue" = "y" ]; then
    paru -S --needed 
else
    echo "Skipping..."
fi

echo "Linking all configs..."


echo "Copying scripts"
git clone https://github.com/m4rti21/tmux-sessionizer ~/Projects/tmux-sessionizer
git clone https://github.com/m4rti21/ctpv ~/Projects/ctpv
git clone https://github.com/m4rti21/compi.nvim ~/Projects/compi.nvim
git clone https://github.com/m4rti21/acc ~/Projects/acc

create_symlink "$HOME/Projects/acc/acc" "$HOME/.local/bin"
create_symlink "$HOME/Projects/tmux-sessionizer/tmux-sessionizer" "$HOME/.local/bin"

create_symlink "$HOME/Projects/ctpv/ctpv" "$HOME/.local/bin"
create_symlink "$HOME/Projects/ctpv/ctpvclear" "$HOME/.local/bin"

cd "$HOME/Projects/ctpv"
make

cd "$start_dir"

echo "All done!"
