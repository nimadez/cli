#!/bin/bash
#
# Set DNS using network-manager (IPv4)

conn=$(nmcli -t -f NAME con show --active | head -n 1)

echo "Connection: $conn"
read -p "DNS (comma-separated): " dns

nmcli connection modify "$conn" ipv4.ignore-auto-dns yes
nmcli connection modify "$conn" ipv4.dns "$dns"

sudo nmcli connection reload
sudo systemctl restart NetworkManager
