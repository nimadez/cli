#!/bin/bash

# fix shutdown problems in some cases

# make backup
sudo cp -rf /etc/default/grub /etc/default/grub.bkp

sudo sed -i 's/^GRUB_CMDLINE_LINUX_DEFAULT="/&acpi=force reboot=warm /' /etc/default/grub
sudo update-grub
