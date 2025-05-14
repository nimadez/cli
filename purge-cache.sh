#!/bin/bash
#
# Purge ~/.cache and temporary files

read -p "press enter to clear cache ..." p

sudo apt autoremove --purge
sudo apt autoclean
sudo apt clean

> ~/.bash_history
> ~/.python_history
> ~/.node_repl_history

rm -rf ~/.cache
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

read -p "press enter to reboot ..." p
sudo reboot
