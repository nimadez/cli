#!/bin/bash
#
# Install minimal gnome-shell with a minimal set of software

sudo apt -y install --no-install-recommends gnome-shell \
                    gdm3 gnome-session gnome-session-xsession \
                    gnome-terminal gnome-disk-utility gnome-system-monitor baobab \
                    nautilus gnome-text-editor gnome-calculator loupe \
                    network-manager-gnome gnome-keyring \
                    gnome-shell-extension-prefs \
                    gnome-tweaks dconf-cli dconf-editor \
                    gnome-characters file-roller \
                    xorg libgdk-pixbuf2.0-bin

echo "Updating database ..."
sudo update-mime-database /usr/share/mime
sudo update-desktop-database /usr/share/applications

# a tiny debloat
systemctl --user mask evolution-addressbook-factory.service
systemctl --user mask evolution-calendar-factory.service
systemctl --user mask evolution-source-registry.service
systemctl --user mask evolution-user-prompter.service
sudo systemctl daemon-reload

# ignore currency exchange rates and fix possible freezes
dconf write /org/gnome/calculator/refresh-interval 0
