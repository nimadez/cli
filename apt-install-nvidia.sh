#!/bin/bash
#
# Install nvidia driver
# make sure secureboot is off, unless you manually sign the drivers
# make sure to install linux kernel headers (apt-install-headers.sh)
# use 'nvidia-xconfig' for older macbook-pro (tesla driver series)

read -p "press enter to install nvidia driver ..." p

sudo apt -y install nvidia-driver firmware-misc-nonfree
#sudo apt -y install nvidia-xconfig nvidia-driver firmware-misc-nonfree

# add to startup
cat > ~/.config/autostart/nvidia-settings.desktop <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Exec=nvidia-settings -l
Terminal=false
Categories=HardwareSettings;System;Settings;
Icon=nvidia-settings
Name=NVIDIA X Server Settings
Comment=Configure NVIDIA X Server Settings
EOF

read -p "press enter to reboot ..." p
sudo reboot
