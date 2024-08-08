#!/bin/bash

mkdir ~/.local/share/gnome-shell/extensions 2>/dev/null
rm -rf ~/.local/share/gnome-shell/extensions/panel-hwinfo@nimadez
cp -r panel-hwinfo@nimadez ~/.local/share/gnome-shell/extensions

read -p "press enter to restart gnome-shell ..." p
sudo service gdm3 restart
