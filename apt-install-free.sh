#!/bin/bash
#
# Install common free software

sudo apt -y install \
    curl aria2 rsync ntfs-3g ffmpeg vlc exiftool \
    fonts-noto-color-emoji \
    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
    \
    git git-gui gitk build-essential cmake nodejs \
    python3-dev python3-pip python3-venv \
    \
    systemd-resolved iptables openssh-server \
    tcpdump iftop privoxy \
    \
    libfuse2 libevent-2.1-7

sudo systemctl enable systemd-resolved
sudo systemctl restart systemd-resolved

sudo systemctl enable privoxy.service
# privoxy.service is later started with "privoxy-config.sh"
