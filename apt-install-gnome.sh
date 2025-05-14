#!/bin/bash
#
# Install gnome-core and gnome software

sudo apt -y install --no-install-recommends gnome-core
sudo apt -y install xorg network-manager-gnome file-roller \
                    gnome-shell-extension-prefs gnome-tweaks
