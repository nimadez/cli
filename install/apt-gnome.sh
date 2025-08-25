#!/bin/bash
#
# Install minimal gnome-shell with a minimal set of software
# (at least 20% faster than gnome-core)
#
# [features]
# - x11 and wayland login
# - dconf editor
# - keyring storage
# - fonts and emoji support
# - nautilus image thumbnails
# - themable (see installation guide in README.md)
#
# Notice: "apt-free.sh" is the complement to this desktop,
# it includes packages that also work in pure Debian command-line.

sudo apt install --no-install-recommends gnome-shell \
                    gdm3 xorg gnome-session gnome-session-xsession \
                    gnome-terminal gnome-disk-utility gnome-system-monitor baobab \
                    nautilus gnome-text-editor gnome-calculator loupe \
                    gnome-keyring \
                    dconf-cli dconf-editor \
                    gnome-characters file-roller \
                    libgdk-pixbuf2.0-bin \
                    fonts-noto-color-emoji fonts-dejavu fonts-dejavu-extra fonts-droid-fallback fonts-noto-mono fonts-urw-base35

# update database
echo "Updating database ..."
sudo update-mime-database /usr/share/mime
sudo update-desktop-database /usr/share/applications

# gnome settings
dconf write /org/gnome/calculator/refresh-interval 0    # ignore currency exchange rates to fix possible freezes

echo "done"
