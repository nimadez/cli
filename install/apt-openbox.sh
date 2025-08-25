#!/bin/bash
#
# Install minimal openbox window-manager (~100 MB deb)
# This is sufficient for running GUI-based applications.
#
# $ startx

sudo apt install --no-install-recommends openbox \
                    xinit xserver-xorg \
                    menu obconf hsetroot \
                    xterm desktop-file-utils

# setup openbox
mkdir ~/.config
cp -a /etc/xdg/openbox ~/.config/
cp /etc/X11/xinit/xinitrc ~/.xinitrc

# append to autostart
echo "hsetroot -solid \"#202024\"" >> ~/.config/openbox/autostart

# update database
echo "Updating database ..."
sudo update-mime-database /usr/share/mime
sudo update-desktop-database /usr/share/applications

echo "done"
