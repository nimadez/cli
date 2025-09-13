#!/bin/bash
#
# Fix wayland nvidia issues
#
# Also be sure to install:
# nvidia-suspend-common
# xorg gnome-session-xsession (if wayland is disabled)

read -p "Enter enable|disable|status: " p

if [ "$p" = "enable" ]; then
    echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee /etc/modprobe.d/nvidia-power-management.conf
    echo "GRUB_CMDLINE_LINUX=\"nvidia-drm.modeset=1 nvidia-drm.fbdev=1\"" | sudo tee /etc/default/grub.d/nvidia-modeset.cfg
    sudo update-grub
    read -p "press enter to reboot ..." p
    sudo reboot
elif [ "$p" = "disable" ]; then
    sudo rm /etc/modprobe.d/nvidia-power-management.conf
    sudo rm /etc/default/grub.d/nvidia-modeset.cfg
    sudo update-grub
    read -p "press enter to reboot ..." p
    sudo reboot
elif [ "$p" = "status" ]; then
    echo "nvidia_drm.modeset: $(sudo cat /sys/module/nvidia_drm/parameters/modeset)"
    echo "nvidia_drm.fbdev: $(sudo cat /sys/module/nvidia_drm/parameters/fbdev)"
    cat /proc/driver/nvidia/params | grep "PreserveVideoMemoryAllocations"
fi
