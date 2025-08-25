#!/bin/bash
#
# Fix wifi for older macbook-pro laptops
#
# - Use smartphone USB Tethering to install debian
# - Install the firmware to fix undetected wifi device
#
# Notice: this non-free-firmware will download drivers
# but you can install it once and backup '/lib/firmware/b43'

sudo apt install firmware-b43-installer
