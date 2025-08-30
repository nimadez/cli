#!/bin/bash
#
# Configuring GRUB to enable hibernate/suspend from a swap file
#
# Notice: We assume that GRUB_CMDLINE_LINUX= is empty
# Test hibernation: systemctl hibernate

SWAPFILE="/swap.img"

if [ ! -f "$SWAPFILE" ]; then
    echo "Help: To create the swap file, first run 'swap-make.sh'."
    exit 1
fi

# get swap file offset
OFFSET=$(sudo filefrag -v "$SWAPFILE" | awk 'NR==4 {print $4}' | sed 's/\.\.//')
if [ -z "$OFFSET" ]; then
    echo "Failed to determine swap file offset."
    exit 1
fi
echo "Swap file offset: $OFFSET"

# find root partition UUID
ROOT_PART=$(findmnt -n -o SOURCE /)
ROOT_UUID=$(sudo blkid -s UUID -o value "$ROOT_PART")
if [ -z "$ROOT_UUID" ]; then
    echo "Failed to determine root partition UUID."
    exit 1
fi
echo "Root partition UUID: $ROOT_UUID"

# update GRUB configuration
CMDLINE="resume=UUID=$ROOT_UUID resume_offset=$OFFSET"
sudo sed -i "s/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX=\"$CMDLINE\"/" /etc/default/grub

sudo update-grub
echo "GRUB configuration updated."

read -p "press enter to reboot ..." p
sudo reboot
