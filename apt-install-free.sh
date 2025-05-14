#!/bin/bash
#
# Install common free software

sudo apt -y install curl aria2 rsync ntfs-3g ffmpeg vlc flite \
                    fonts-noto-color-emoji libfuse2 \
                    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
                    \
                    git git-gui gitk build-essential nodejs \
                    python3-dev python3-pip python3-venv \
                    exiftool libevent-2.1-7 \
                    iptables openssh-server tcpdump iftop \
                    systemd-resolved

sudo systemctl enable systemd-resolved
sudo systemctl restart systemd-resolved
