# CLI
```
🌀 DebianDay 2025 
Debian's 32nd birthday next Saturday!
https://wiki.debian.org/DebianDay/2025
```

<img src="media/debian.png" width="180">

### Debian Assistant CLI

> This repository contains various scripts ```~100 kb``` for working with the Debian OS and the Linux kernel, from installation to everyday scripts. This repository is not optimized for the end-user in any way, does not contain any binaries, and ***does not include scripts that could cause security issues***. System scripts are as POSIX-compliant as possible.

### Minimal Debian Installation
Kernel: ```6.12.41```<br>
Branch: ```Trixie```<br>
Display servers: ```X11``` ```Wayland```<br>
Desktop: ```GNOME (gnome-shell)```<br>
Last update: ```16-Aug-2025 (debian-13.0.0)```<br>
Time required: ```~25 minutes (3-5 Mb/s)```<br>
Known issues: ```none```<br>
```
0- [Disable Secure Boot]

   $ sudo mokutil --disable-validation
```
```
1- [Install Debian]

   - Select "Expert Install"
   - Install minimal Debian to start from command-line
   - Do not select "allow login as root" to enable the "sudo" command
   - Do not download or install extras
   - Do not select any desktop in tasksel

   Minimum recommended partitions:
      ├─ #1 VFAT  /boot/efi   ==1.0 GB
      ├─ #2 EXT4  /           >=16.0 GB (>24.0 GB swap as file, depends on RAM)
      ├─ #3 EXT4  /home       ∞
      └─ #4 EXT4  /media      ∞
      * I don't use a swap partition because I want it to be variable.

   $ sudo apt edit-sources    # comment out the "cdrom" line if needed
```
```
2- [Setup Networking]

   [Automatic via Tether]
   net-tether.sh              # quick setup USB tethering

   [Manual via Ethernet]
   $ ip link
   $ sudo nano /etc/network/interfaces
   Add lines:
      allow-hotplug {interface-name}
      iface {interface-name} inet dhcp
   $ sudo service networking restart
```
```
3- [Clone Repository]

   $ sudo apt install git
   $ git clone https://github.com/nimadez/cli
```
```
4- [Select Branch]

   apt-sources.sh             # generate sources (debian only, no extra sources)
   $ sudo apt update
   $ sudo apt full-upgrade
   $ sudo reboot              # reboot if there are any major updates or kernel updates
```
```
5- [Software Installation]

   apt-install-headers.sh     # install kernel headers
   apt-install-nvidia.sh      # install nvidia driver, reboot is required (non-free - optional)
   apt-install-cuda.sh        # install nvidia cuda toolkit (non-free - optional)
   apt-install-free.sh        # install common free software (99.8% free)
```
```
6- [Desktop Installation]

   [GNOME: ~270 MB deb]
   apt-install-gnome.sh       # minimal gnome-shell with a minimal set of software (free)
   patch/gnome-ethernet.sh    # fix undetected ethernet
   patch/gnome-panel-style.sh # add styles to panel, such as transparency (customizable)

   [WM Openbox: ~100 MB deb]
   apt-install-openbox.sh     # minimal openbox with a minimal set of software (free)
```
```
7- [Verify Installation]

   about.sh                   # get basic information about the system
   about-kernel.sh            # get the kernel log and check for possible errors
   about-root.sh              # get list of / permissions
   about-users.sh             # get list of users
   about-groups.sh            # get list of groups
   about-services.sh          # get list of all active services
   apt-history.sh             # get apt history and what was done
   apt-list.sh                # get the number and list of available packages
```
```
8- [Finish Installation]

   $ cp /etc/skel/.bashrc ~   # if the home partition is formatted, copy the .bashrc file
   patch/wayland-nvidia.sh    # fix wayland nvidia issues (if you want to enable wayland)
   
   swap-make.sh               # make a swap file if you don't have a swap partition
   swap-grub.sh               # run only if you are not installing any desktop (hibernate debian)
   keygen-ssh.sh              # generate ssh keys (optional)
   keygen-ssl.sh              # generate ssl keys (optional)
   purge-cache.sh             # purge ~/.cache if you don't keep permanent files there
```
> - All steps and scripts are updated with each installation to include any missing changes.
> - Trixie "stable-proposed" branch without "backports" is recommended. (option 3 in step 4)
> - Remember to reinstall kernel headers after every kernel update. ("testing" branch only)
> - You can skip step 6 and use pure Debian via the command-line.

### Install Scripts
![installer](media/installer.png)
```
$ sh cli-install.sh
$ cli
```

## FAQ
#### How to create a startup script?
```
$ nano ~/.config/autostart/startup.sh
$ nano ~/.config/autostart/startup.desktop

[Desktop Entry]
Type=Application
Name=Startup
Exec=x-terminal-emulator -e "sh /home/<USER>/.config/autostart/startup.sh"
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
X-GNOME-Autostart-Delay=10
```

#### What happened to the hwinfo gnome-extension?
```
I try not to depend on gnome or any other desktop.

For transparent panel: see "patch/gnome-panel-style.sh"
For hardware monitor: see "hw-info.sh" and add it to the startup script
```
![hwinfo](media/hwinfo.png)

#### Wayland issues
```
See "patch/wayland-nvidia.sh" to setup wayland

These issues have no solution:
[NVIDIA]
- "nvidia-x-server" is not fully working
- "nvidia-settings" isn't fully functional, but you can adjust the fans
[WACOM]
- Serious annoying problems
- https://github.com/linuxwacom/xf86-input-wacom/wiki/Wayland
[SCRIPTS]
- "screencast-term.sh" does not work on gnome-terminal

These issues have been resolved:
[CHROMIUM/ELECTRON]
- Chromium 141.0.7359.0 (tested)
- Electron 37.0.0 (tested)
- No additional command-line switches are required

* If you really want to work with your computer and not just
spend time experimenting, wayland is not for you right now.
```

#### How to enter the command-line before display-manager after installing the desktop?
```
1. Reboot
2. During the GRUB boot menu, press the 'e' key
3. Add the number '3' to the end of the line that starts with 'linux /boot'
   linux /boot/vmlinuz-... root=... quite 3
4. Press Ctrl + x
```

## History
```
↑ Upgrade to Debian 13 Trixie
↑ All Linux, currently all my devices are Linux based
↑ Celebrating 1 year with Linux on the everyday desktop PC 🎂
↑ Wine requirement reduced to zero, migration completed
↑ Debian Assistant CLI
↑ Q1 2024 - Migrating to Debian Linux after 30 years of MS-DOS/Win32
↑ Created in 2019 for system automation on Windows machine

"A machine can reprogram another machine from scratch."
```

> 🎭 *"I had something like undo syndrome in the first year, which was both annoying and pleasant in the mornings. Today, that condition seems to be gone, but a little of that pleasant mood still remains."*

## License
Code released under the [GPL-3.0 license](https://github.com/nimadez/cli/blob/main/LICENSE).

## Credits
- [Linus Torvalds](https://github.com/torvalds)
- [Linux Kernel](https://github.com/torvalds/linux)
- [Debian](https://www.debian.org/)
- [GNOME](https://www.gnome.org/)
