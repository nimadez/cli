#!/bin/bash
#
# Install minimal GNOME (gnome-shell) with a minimal set of software (~300 MB deb)
# At least 20% faster than gnome-core.
#
# [features]
# - x11 and wayland login
# - gnome keyring daemon
# - dconf editor
# - fonts and emoji support
# - characters and emoji browser
# - nautilus image thumbnails
# - themable (see installation guide in README.md)
#
# Notice: "apt-com.sh" is the complement to this desktop.

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
