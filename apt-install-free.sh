#!/bin/bash
#
# Install common free software

sudo apt -y install --no-install-recommends \
    curl aria2 rsync vlc libimage-exiftool-perl mkisofs \
    fonts-noto-color-emoji fonts-dejavu fonts-dejavu-extra fonts-droid-fallback fonts-noto-mono fonts-urw-base35 \
    gstreamer1.0-plugins-good \
    \
    git git-gui gitk build-essential cmake nodejs \
    python3-dev python3-pip python3-venv \
    \
    systemd-resolved iptables openssh-server wpasupplicant \
    tcpdump iftop privoxy \
    \
    libfuse2 libevent-2.1-7 \
    \
    qemu-system qemu-system-gui qemu-utils \
    libvirt-clients libvirt-daemon-system \
    \
    xterm

# setup systemd-resolved
sudo systemctl enable systemd-resolved
sudo systemctl restart systemd-resolved
sudo service networking restart

# setup libvirt
sudo adduser $(whoami) libvirt

# setup privoxy
sudo systemctl enable privoxy.service
# privoxy.service is later started with "privoxy-config.sh"

# remove xterm .desktops
sudo rm /usr/share/applications/debian-xterm.desktop
sudo rm /usr/share/applications/debian-uxterm.desktop
