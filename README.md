# My Dotfiles

This my personal Hyprland config for Arch Linux.
Wallpapers here:
[https://drive.m4rti.dev/s/zByAm9WtkDFNKXy](https://drive.m4rti.dev/s/zByAm9WtkDFNKXy)

## Desktop 
```sh
dwl                     # WM/Compositor
xdg-desktop-portal-wlr  # screenshare portal
xdg-desktop-portal-gtk  # file picker portal
xdg-user-dirs           # something
wbg                     # wallpaper
tofi                    # run launcher
wl-gammarelay-rs        # brightness/nightmode
wl-clipboard            # clipboard on wayland
wl-clip-persist         # clipboard persist on wayland
xclip                   # clipboard on X11
cliphist                # clipboard history
slurp                   # screenshot
grim                    # screenshot
```

## Audio
```sh
pipewire 
pipewire-pulse
wireplumber 
alsa-utils 
pulsemixer
```

## Terminal
```sh
zsh                 # shell
foot                # terminal
eza                 # ls replacement
bat                 # better cat
jq                  # json parser
btop                # tui system monitor
rocm-smi-lib        # btop dependency for gpu monitoring on AMD
fastfetch           # better neofetch
tmux                # terminal multiplexer
tmate               # tmux remote
trash-cli           # rm replacement
stow                # dotfile manager
```

#### File management
```sh
lf                  # file manager
ripdrag             # drag from terminal 
ctpv                # file preview handler
chafa               # image preview
ffmpegthumbnailer   # video preview
perl-file-mimeinfo  # mimeopen command

zip
unzip
unrar
tar
p7zip
```

#### Other apps
```sh
imv                 # image viewer
mpv                 # video player
zathura             # pdf viewer
zathura-pdf-poppler # pdf plugin
newsboat            # rss reader
neovim              # text editor
gimp                # image editor (FLATPAK)
inkscape            # vector graphics (FLATPAK)
texlive             # pdf compiler
```
#### Mount External Drives
```sh
udiskie             # automount drives
```
#### Manage Keys
```sh
gnome-keyring       # application key manager
bitwarden           # password manager (FLATPAK)
```

## Flatpaks
```sh
flatpak
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

## Add Windows Partition to systemd-boot
```sh
# Mount Windows boot partition (sda1 example)
sudo mount /dev/sda1 /mnt/windows
cd /mnt/windows/EFI
sudo cp -r Microsoft /boot/EFI
```

## Other
```sh
i2c-ch341-dkms      # 3D printer arduino drivers
```

## QEMU/KVM
Install KVM Packages:
```sh
paru -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat ebtables iptables
# For TPM support (windows 11) install
paru -S swtpm 
```
Sources:
- [Setting up QEMU/KVM with virt-manager](https://forum.manjaro.org/t/how-to-setting-up-qemu-kvm-with-virt-manager/127431/1)
- ["TPM version 2.0 is not supported" QEMU/KVM](https://www.reddit.com/r/archlinux/comments/15mjqap/tpm_version_20_is_not_supported_qemukvm/)
