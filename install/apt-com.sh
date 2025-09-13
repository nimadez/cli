#!/bin/bash
#
# Install common free software

sudo apt install --no-install-recommends \
    network-manager wpasupplicant polkitd \
    systemd-resolved iptables openssh-server \
    rinetd tcpdump iftop \
    \
    git gitk build-essential cmake \
    python3-dev python3-pip python3-venv nodejs perl \
    \
    curl aria2 rsync genisoimage \
    \
    vlc xterm zenity wmctrl \
    \
    libevent-2.1-7 libfuse2

# restart networks
sudo systemctl enable systemd-resolved
sudo systemctl restart systemd-resolved
sudo systemctl restart networking

# hide xterm desktop icons
if [ -r "/usr/share/applications/debian-xterm.desktop" ]; then
    if ! grep -q "NoDisplay=true" "/usr/share/applications/debian-xterm.desktop"; then
        echo "NoDisplay=true" | sudo tee -a "/usr/share/applications/debian-xterm.desktop" >/dev/null
    fi
    if ! grep -q "NoDisplay=true" "/usr/share/applications/debian-uxterm.desktop"; then
        echo "NoDisplay=true" | sudo tee -a "/usr/share/applications/debian-uxterm.desktop" >/dev/null
    fi
fi

echo "done"
