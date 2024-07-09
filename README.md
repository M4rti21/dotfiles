# My Dotfiles

This my personal Hyprland config for Arch Linux.

## Desktop 
```bash
hyprland                        # WM/Compositor
xdg-desktop-portal-hyprland     # screenshare portal
xdg-desktop-portal-gtk          # file picker portal
waybar                          # panel 
hyprpaper                       # wallpaper
tofi                            # run launcher
wl-gammarelay-rs                # brightness/nightmode
```

## Audio
```bash
pipewire 
pipewire-pulse
wireplumber 
alsa-utils 
pavucontrol 
```

#### Terminal
```bash
zsh         # shell
foot        # terminal
exa         # ls replacement
btop        # tui system monitor
fastfetch   # better neofetch
tmux        # terminal multiplexer
```

## File Management
#### File manager
```bash
lf              # file manager
ripdrag         # drag from terminal 
ctpv            # file preview handler
chafa           # image preview

zip
unzip
unrar
tar
7z

imv             # image viewer
mpv             # video player
zathura         # pdf viewer

nvim            # text editor
gimp            # image editor (FLATPAK)
inkscape        # vector graphics (FLATPAK)
groff           # pdf compiler

trash-cli       # rm replacement
wl-clipboard    # clipboard
```
#### Mount External Drives
```bash
udiskie         # automount drives
```
#### Manage Keys
```bash
gnome-keyring   # application key manager
bitwarden       # password manager (FLATPAK)
```

## Flatpaks
```bash
flatpak
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# For themes
xsettingsd
```
## Add Windows Partition to systemd-boot
```bash
# Mount Windows boot partition (sda1 example)
sudo mount /dev/sda1 /mnt/windows
cd /mnt/windows/EFI
sudo cp -r Microsoft /boot/EFI
```

## QEMU/KVM
Install KVM Packages:
```bash
paru -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables
# For TPM support (windows 11) install
paru -S swtpm 
```
Sources:
- [Setting up QEMU/KVM with virt-manager](https://forum.manjaro.org/t/how-to-setting-up-qemu-kvm-with-virt-manager/127431/1)
- ["TPM version 2.0 is not supported" QEMU/KVM](https://www.reddit.com/r/archlinux/comments/15mjqap/tpm_version_20_is_not_supported_qemukvm/)
