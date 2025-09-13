#!/bin/bash
#
# Install minimal Sway wayland compositor for experimental purposes
#
# GNOME: login to sway  (no need to install additional software, GPU acceleration works)
# PM/VM: $ sway         (needs a display manager, but I prefer to have access to the Debian command-line)
#
# Terminal: ALT Enter
# App Launcher: ALT D
# Fullscreen window: ALT F
# Switch tile/float: ALT SHIFT SPACE
# Kill window: ALT Q
# Reload configs: ALT SHIFT C / ALT SHIFT R
# Exit: ALT SHIFT E / ALT SHIFT Q

sudo apt install --no-install-recommends sway wmenu

# setup sway
mkdir -p ~/.config/sway
cp /etc/sway/config ~/.config/sway/

sed -i 's/set $mod Mod4/set $mod Mod1/g' ~/.config/sway/config # enable ALT
sed -i 's/set $term foot/set $term x-terminal-emulator/g' ~/.config/sway/config
sed -i 's/set $menu wmenu-run/set $menu wmenu-run -p MENU -l 10/g' ~/.config/sway/config
sed -i 's/bindsym $mod+Shift+q kill/bindsym $mod+q kill/g' ~/.config/sway/config
cat >> ~/.config/sway/config << EOF
# [USER]
bindsym \$mod+Shift+r swaymsg reload
output * bg #202024 solid_color
hide_edge_borders smart
gaps inner 0
gaps outer 0
#for_window [app_id=".*"] floating enable
#for_window [app_id=".*"] border csd
exec x-terminal-emulator
EOF

read -p "Install Foot Terminal? (Y/y): " p
if [ "$p" = "y" -o "$p" = "Y" ]; then

    sudo apt -y install --no-install-recommends foot

    mkdir ~/.config/foot
    cat > ~/.config/foot/foot.ini <<EOF
app-id=foot
title=Terminal
locked-title=no
font=monospace:size=10
term=xterm-256color
[colors]
background=1E1E1E
foreground=F8F8F8
EOF

    # setup bashrc
    if [ ! -f ~/.bashrc ]; then
        cp /etc/skel/.bashrc ~
    fi
    sed -i 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc
fi

# fix GNOME and NVIDIA login issue
if dpkg -l | grep "gdm3" >/dev/null; then
    sudo sed -i 's/Exec=.*$/Exec=sway --unsupported-gpu/g' /usr/share/wayland-sessions/sway.desktop
fi

echo "done"
