# My Dotfiles

This my personal qtile config for Arch Linux.

## Desktop 
```bash
paru -S hyprland xdg-desktop-portal-hyprland waybar hyprpaper hyprcursor pyprland wofi wl-gammarelay-rs
```

## Audio
```bash
paru -S pipewire wireplumber alsa-utils pavucontrol 
```

## File Management
```bash
# Your file manager of choice
paru -S pcmanfm-gtk3
# Trash support
paru -S gvfs
# Archive (zip/unzip)
paru -S xarchiver
# Mount External Drives + Manage Keys
paru -S polkit-gnome gnome-keyring
```
## Terminal goodies
```bash
# My prefered Terminal + kitty for backup
paru -S alacritty kitty
# My prefered shell
paru -S fish
# we can check our available shells with
# cat /etc/shells 
# then change our user default shell
chsh-s /usr/bin/fish 
# Better ls
paru -S exa
# Better rm
paru -S trash-cli
# TUI System Monitor
paru -S btop
# Faster Neofetch
paru -S fastfetch
```

## Coding
```bash
paru -S git vim nvim tmux
```

## Flatpaks
```bash
paru -S flatpak
# For themes
paru -S xdg-desktop-portal-gtk xsettingsd

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
