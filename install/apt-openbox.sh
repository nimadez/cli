#!/bin/bash
#
# Install minimal openbox x11 window-manager (~100 MB deb)
#
# This is sufficient for running GUI-based applications,
# but it is more suitable for VM and light hardware.
#
# $ startx

sudo apt install --no-install-recommends openbox \
                    xinit xserver-xorg-core xserver-xorg-input-libinput \
                    x11-xserver-utils menu obconf desktop-file-utils \
                    alacritty mc openssh-server

# setup openbox
mkdir ~/.config
cp -a /etc/xdg/openbox ~/.config/
cp /etc/X11/xinit/xinitrc ~/.xinitrc
cp /etc/skel/.bashrc ~

# setup autostart
cat > ~/.config/openbox/autostart <<EOF
xsetroot -solid "#202024"
EOF

# setup menu
custom_items='
<item label="Terminal">
    <action name="Execute"><execute>x-terminal-emulator</execute></action>
</item>
<item label="Midnight">
    <action name="Execute"><execute>x-terminal-emulator -e mc</execute></action>
</item>
<menu id="applications-menu" label="Applications" execute="/usr/bin/obamenu"/>
<separator />
<item label="Edit Alacritty">
    <action name="Execute"><execute>x-terminal-emulator -e nano ~/.config/alacritty/alacritty.toml</execute></action>
</item>
<item label="Edit Autostart">
    <action name="Execute"><execute>x-terminal-emulator -e nano ~/.config/openbox/autostart</execute></action>
</item>
<item label="Edit Config">
    <action name="Execute"><execute>x-terminal-emulator -e nano ~/.config/openbox/rc.xml</execute></action>
</item>
<item label="Edit Menu">
    <action name="Execute"><execute>x-terminal-emulator -e nano ~/.config/openbox/menu.xml</execute></action>
</item>
<item label="Edit Environment">
    <action name="Execute"><execute>x-terminal-emulator -e nano ~/.config/openbox/environment</execute></action>
</item>
'
cat > ~/.config/openbox/menu.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>

<openbox_menu xmlns="http://openbox.org/"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://openbox.org/
                file:///usr/share/openbox/menu.xsd">

<menu id="root-menu" label="Openbox 3">
  $custom_items
  <separator />
  <item label="ObConf">
    <action name="Execute"><execute>obconf</execute></action>
  </item>
  <item label="Reconfigure">
    <action name="Reconfigure" />
  </item>
  <separator />
  <item label="Restart">
    <action name="Restart" />
  </item>
  <item label="Exit">
    <action name="Exit" />
  </item>
</menu>
</openbox_menu>
EOF

# setup alacritty
mkdir ~/.config/alacritty
cat > ~/.config/alacritty/alacritty.toml <<EOF
[window]
dimensions = { columns = 80, lines = 25 }
decorations = "Full"
decorations_theme_variant = "Dark"
padding = { x = 2, y = 2 }
[font]
normal = { family = "monospace", style = "Regular" }
size = 10.0
[colors.primary]
foreground = "#eeeeee"
background = "#1e1e1e"
EOF

# update database
echo "Updating database ..."
sudo update-mime-database /usr/share/mime
sudo update-desktop-database /usr/share/applications

# remove waste
sudo apt autoremove --purge vim-tiny vim-common

echo "done"
