#!/bin/bash
#
# Install nvidia driver
# make sure secureboot is off, unless you manually sign the drivers
# make sure to install linux kernel headers (apt-install-headers.sh)

read -p "press enter to install nvidia driver ..." p

sudo apt -y install nvidia-kernel-dkms nvidia-driver firmware-misc-nonfree \
                    nvidia-suspend-common

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

# add to startup
mkdir ~/.config/autostart
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
