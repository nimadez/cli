#!/bin/bash
#
# Unlock apt and fix corrupted install
# notice: use with caution, this should be the last step you take.

sudo rm -rf /var/lib/dpkg/lock
sudo rm -rf /var/lib/dpkg/lock-frontend
sudo rm -rf /var/cache/apt/archives/lock
sudo dpkg --configure -a
sudo apt --fix-broken install
sudo apt autoremove --purge
sudo apt update
