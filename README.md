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

### My thoughts on using linux
(just me yapping for a while so dont read this)

I wanted to write down my thoughts on my journey so far with linux

TLDR: Linux is increadible and i cant see myself ever going back.

[03/05/2024]

I have now been daily driving linux on my home computer for about 6 months and 
i see no future where i'd go back

The first time i ever used linux was in 2020 when I was studying 
"Sistemes Microinformatix i Xarxa (SMiX)" (we'll call it Networking School) 
and as an optional activity we had to do a remote connection from 2 ubuntu 
virtual machines. I didnt think much about it at the time, it felt cool 
using a different operating system, as I had only ever used Windows, 
and even though my dad uses MacOS, i had never used it.

My first impressions where a big releaf, as what i had heard about linux 
until that time was that linux was only for programmers and for "hackers" 
and how it was very hard to use. Ubuntu as my first experience with it was 
very pleasent.
I still remember the thing that shoked me the most was how easy it actually 
was to install... and what I mean with that is that if you have ever installed 
windows, the menus on the installer are still styled like in the windows vista 
era and feel very outdated, meanwhile the ubuntu installer felt up to date, feltm
more easy to use and gave me more confidence on what i was doing.

Fast forward about a year since then and I entered 2nd year of Networking School
and this year we used linux way more, we mainly only used OpenSUSE for all the
homework and i got to see more about how linux worked, what was upsetting to me
was that the teacher's activities where ment for a version of OpenSUSE published 
in 2010 or so, and even though I got told by the teacher that i would have no
help from their end I decided to install the newest version of OpenSUSE so that
i could get a grasp of what it was like nowadays (2022). It was so much better,
the GNOME desktop it shipped with was so much different than the 2010 version,
also i decided to install the KDE plasma desktop on the installer alongside GNOME
and then i learned about Desktop Envoirments and how much linux could be costumized.

I had a friend in my class that also got very interested in linux, and we decided
to use linux on our school laptops, we didnt need them for much more than for 
using virtualbox and google drive, so basically 0 problems regardless of what OS
we where to use. We both installed LinuxMint which looked to be easy to newcommers
and looked pretty sleak.

At first we both just expreienced the vanilla LinuxMint + Cinnamon desktop expreience
it was pretty cool being able to change icon themes, cursor themes, and the whoel
application theme right from the settings app, also the concept of actually using
a software store on your computer as you do on your phone was very appealing,
no need to search the internet to download a .exe, just open the store and download
the app you want, like on your smartphone (no the Windows Store doesn not count, 
its garbage, lacks most software, and noone uses it). 

Later on we started to dip more into the terminal and started using a couple terminal
based utilities like htop, tty-clock, neofetch (ofc), and installing software form the command line
instead of the graphical store, it felt very nice, i could understand how lots
of people prefer it, and how its hard to go back, once you know how to do something
on the terminal you can just, do it, while with a GUI you have to navigat through menus
scroll down pages untill you find the button that does what you wanted to do, the
"straightforwardness" of the cli changed my view on terminal applications.

Now I was more into the linux world and I started watching some YouTube channels
about linux, I distincly remember that DT (DistroTube) had lots of videos on 
various linux topics and that's how I learned about Tiling Window Managers, it
looked so interesting, how efficient it looked, how it made a very good use of 
virtual workspaces (which made lots of sense on a laptop screen) and i still
didnt feel like i was ready so i decided to tweak the Cinnamon desktop to act 
close to a Tiling Window Manager, i removed the launcher on the bar and installed
an application launcher, i found a tiling plugin that auto tiled my windows and 
i didnt have to leave the comfort of my already used desktop.

Then my friend installed qtile on his laptop and i didnt want to fall behind so
i looked into window managers and found a cool BSPWM rice on unixporn, i wanted
to copy his config but i noticed how the instructions where for Arch Linux, at
that time i had heard about Arch Linux and how it was "hard to install" and so
i found i "Arch Linux GUI Installer" online that simplified the process, by
doing what other distros do with a live envoirment and a graphicall installer.
From there in installed BSPWM and and copied the unixporn config and had my
setup on a good spot.

I used that for a while and using a tiling window manager was increadible, not ever
having to resize windows as all of them used my screen realstate so efficiently
felt amazing. I also tried to play with Arco Linux but i didnt like their default
configuration and so i ended going back to my Arch Linux GUI Installer setup in BSPWM

Then the school year ended, and I wanted to use my laptop to play some games
when i wasnt home and so my linux journey ended as I installed Windows 10 back
so that i could play games on it. I instantly missed how fun to use my computer 
was while on linux and how excited I felt every time I installed a new package
or configured a program to my liking, but I ignored those feelings and just
used windows to play my games.

A whole year passed and linux started making a comeback to my life in the form
of some recomended videos here and there, I also hang out in discord and I
started seeing some people using linux to play osu! the videogame I play the most
but I didnt do much about it.

Then one day in september 2023 something was acting up on my Windows Desktop
at home, i dont remember the specific program, but it bothered me a lot, i couldnt
do anything to fix it, then discord also started messing up to the point where
i used the web app for 2 weeks until i was fed up, if the whole point of Windows
is that "everything just works" an shit still breaks, there is no poit of me
being there, also i was starting to get more privacy concious and was trying to
de-google my life amongst other things, so linux made sense again.

I also sold my current Audio Interface (Audient ID14 MKII) as it didnt have linux
drivers and bought the Focusrite Scarlett 2i2 gen 4, as it didnt require drivers to work

My first thought was to go back to the Arch Linux GUI installer i last used on
my school laptop, but sadly that was no longer mantained, so I decided to use
Manjaro, that worked for about a week but i suddently started to notice things
missing from my windows desktop, things like Photoshop or Premiere, some games
not working great, and some other apps not having a linux version, and so i 
went back to windows, but i had the linux thought in my head and it wasnt leaving.
After a month i decided to go back into linux and this time i did it with Pop!_OS
as it was said it had better compatibility with games and also good Nvidia Driver
support. Same thing happened, i used it for a week, started missing things form
windows and went back to good'ol Billy G's OS.
Finally in december 2023 I decided i was leaving windows for good, althoug not really.
I installed EndeavourOS, another Arch based distro, but this time it was alongside
Windows and so whenever something wouldnt work on linux, i could just reboot into
windows and get it done. This is what allowed me to do a meaningfull step in my 
linux journey, i was nolonger afraid that i might have to leave linux behind, I
had the best of both worlds and I was very happy about it.

On EndeavourOS i used XFCE for a bit but then remembered how good WindowManagrers
were and so i decided to use Qtile, i configured exactly to my liking, (config should be on 
this dotfies), and life was perfect.

Also i switched to arch about 1 month into EndeavourOS because i felt ready 
to take on a leap to a more costumizable setup.

The months passed and I started noticing a pattern, all the things i had to go
back into windows to do, where starting to get replaced by its linux counterparts:
Photoshop slowly became Gimp / Photopea (still not 100% there), i had to 
edit a quick video and i did it on KdenLive, and for SVGs i started to use Inkscape
(not that i knew how to use Ilustratior a lot), also I was now more concious about
FOSS and the importance of it, and started replacing other programs aswell, 
like using firefox for my browser instead of google chrome. But also something 
happened with games, I never was of the kind that play lots of different videogames, 
I play 1 game and i play it a lot, i sometimes go into another games to play with
friends, but this doesnt extend longer than a day or two for the most part, and
so I started feeling like going back to windows to get to play this games wasnt worth, 
if the game couldn't be played through wine or proton it wasnt worth playing...

I have been trying out Hyprland for a month now and I've been loving it, its still
not a perfect experience as i still have Nvidia and play videogames on it, but
i love how good it looks, the good multimonitor support:
```
current setup:
Display (SONY TV): 1920x1080 @ 60Hz [External]
Display (XV252Q F): 1920x1080 @ 390Hz
Display (PHL 241V8): 1920x1080 @ 60Hz
Display (PHL 241V8): 1080x1920 @ 60Hz
```
So i will try to stick with it and see where all this goes!

I could rant about NVIM and TMUX which have been a gamechanger for my programming
journey recently but its just gonna be more yapping about FOSS and terminal apps
being increadibly fast, lightweight and amazing! so im not gonna go there.

But this are my thoughts so far...
