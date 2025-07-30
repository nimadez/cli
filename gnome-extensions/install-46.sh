#!/bin/bash

# GNOME 46

mkdir ~/.local/share/gnome-shell/extensions 2>/dev/null
rm -rf ~/.local/share/gnome-shell/extensions/panel-hwinfo-46@nimadez
cp -r panel-hwinfo-46@nimadez ~/.local/share/gnome-shell/extensions

read -p "press enter to restart gnome-shell ..." p
sudo service gdm3 restart
