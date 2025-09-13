#!/bin/bash
#
# Redirect connections from address/port to another address/port
#
# Dependencies: rinetd
#
# - It also checks if the bind/connect address already exists
# - It can be used to edit configurations when no arguments are entered
# - If the service does not restart (not "done"), your settings are incorrect or the port is busy
# - It's a good idea to restart the rinetd service from time to time to clear the cache

if [ $# -gt 0 ]; then
    if [ $# -eq 2 ]; then
        bind=$(echo "$1" | tr ':' ' ')
        conn=$(echo "$2" | tr ':' ' ')
        grep -F "$bind $conn" /etc/rinetd.conf || echo "$bind $conn" | sudo tee -a /etc/rinetd.conf
        sudo systemctl enable rinetd &>/dev/null
        sudo systemctl restart rinetd
        echo "done"
    else
        echo "Usage: net-forward.sh [bind:port] [connect:port]"
    fi
else
    sudo nano /etc/rinetd.conf
    sudo systemctl enable rinetd &>/dev/null
    sudo systemctl restart rinetd
    echo "done"
fi
