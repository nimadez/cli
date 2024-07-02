#!/bin/bash

sudo apt -y install ffmpeg gimp vlc

# utils
sudo apt -y install curl aria2 rsync ntfs-3g

# fonts
sudo apt -y install fonts-noto-color-emoji

# libs
sudo apt -y install libfuse2 # appimage

# codecs
sudo apt -y install gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly

# ufw firewall (not recommended)
#sudo apt -y install ufw
#sudo ufw enable
