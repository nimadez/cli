#!/bin/bash
#
# Install nvidia driver
#
# Notice: Make sure to install linux kernel headers (apt-sys-headers.sh)

sudo apt install nvidia-kernel-dkms nvidia-driver nvidia-suspend-common firmware-misc-nonfree

sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service

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

echo "done"
read -p "press enter to reboot ..." p
sudo reboot
