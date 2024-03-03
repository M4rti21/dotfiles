## update system
sudo pacman -Syu
## necessary packages
sudo pacman -S qtile picom fish exa rofi alsa-utils polkit-gnome gvfs git xorg-xrandr pavucontrol dunst 
## optional packages
sudo pacman -S alacritty firefox fastfetch pcmanfm xarchiver tmux neovim btop
## clone the repository
cd ~
git clone https://github.com/m4rti21/dotfiles.git
## backup old dotfiles as 'name'-'date'.bak
cd .config
mv qtile qtile-$(date +%Y%m%d).bak
mv picm picom-$(date +%Y%m%d).bak
mv fish fish-$(date +%Y%m%d).bak
mv alacritty alacritty-$(date +%Y%m%d).bak
mv rofi rofi-$(date +%Y%m%d).bak
mv dunst dunst-$(date +%Y%m%d).bak
mv fastfetch fastfetch-$(date +%Y%m%d).bak
mv nvim nvim-$(date +%Y%m%d).bak
mv tmux tmux-$(date +%Y%m%d).bak
## create symlinks
ln -s ~/dotfiles/.config/qtile
ln -s ~/dotfiles/.config/picom
ln -s ~/dotfiles/.config/fish
ln -s ~/dotfiles/.config/alacritty
ln -s ~/dotfiles/.config/rofi
ln -s ~/dotfiles/.config/dunst
ln -s ~/dotfiles/.config/fastfetch
ln -s ~/dotfiles/.config/nvim
ln -s ~/dotfiles/.config/tmux
cd ~
mv .themes .themes-$(date +%Y%m%d).bak
ln -s ~/dotfiles/themes .themes
mv .icons .icons-$(date +%Y%m%d).bak
ln -s ~/dotfiles/icons .icons
cd ~/.local/share/
mv fonts fonts-$(date +%Y%m%d).bak
ln -s ~/dotfiles/fonts
mv icons icons-$(date +%Y%m%d).bak
ln -s ~/dotfiles/icons
