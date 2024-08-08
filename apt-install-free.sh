#!/bin/bash

read -p "press enter to install [COMMON] ..." p
sudo apt -y install curl aria2 rsync ntfs-3g vlc gimp fonts-noto-color-emoji libfuse2t64 \
                    gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly

read -p "press enter to install [DEV] ..." p
sudo apt -y install git git-gui gitk build-essential nodejs \
                    python3-dev python3-pip python3-venv \
                    libevent-2.1-7t64 lshw exiftool flite

read -p "press enter to install [NETWORK] ..." p
sudo apt -y install iptables openssh-server tcpdump iftop

# no wine32:i386, see apt-install-wine32.sh
read -p "press enter to install [WINE] ..." p
sudo apt -y install wine

read -p "press enter to install [RESOLVER] ..." p
sudo apt -y install systemd-resolved
sudo systemctl enable systemd-resolved
sudo systemctl restart systemd-resolved
