#!/bin/bash

# fix wifi for older macbook-pro laptops

# use smartphone USB Tethering to install debian bookworm
# install this non-free-firmware to fix undetected wifi device
# you also need to setup wifi because wifi is ignored by the debian installer

# notice: this non-free-firmware will download drivers

sudo apt install firmware-b43-installer
