#!/bin/bash

# GNOME 43
# GTop is required (backported from GNOME 46)

sudo apt -y install gir1.2-gtop-2.0

mkdir ~/.local/share/gnome-shell/extensions 2>/dev/null
rm -rf ~/.local/share/gnome-shell/extensions/panel-hwinfo-43@nimadez
cp -r panel-hwinfo-43@nimadez ~/.local/share/gnome-shell/extensions

echo Installed.
echo Press Alt + F2
echo Type 'r' and press enter
