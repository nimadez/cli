#!/bin/bash
#
# I'm not playing games, but I have tested this script and
# successfully played DOTA 2 plus some indie games for a day.

sudo dpkg --add-architecture i386
sudo apt update

sudo apt -y install mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386
sudo apt -y install libgl1-nvidia-glvnd-glx:i386
sudo apt -y install steam-installer
