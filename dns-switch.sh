#!/bin/bash
#
# Switch DNS using GNOME NetworkManager

nmcli connection
read -p "Name: " name

echo - "1.1.1.1, 8.8.4.4"
echo - "1.1.1.1, 1.0.0.1"
echo - "8.8.8.8, 8.8.4.4"
echo - "208.67.222.222, 208.67.220.220"
echo - "156.154.70.1, 156.154.71.1"
read -p "DNS: " dns

nmcli connection modify $name ipv4.ignore-auto-dns yes
nmcli connection modify $name ipv4.dns "$dns"

sudo nmcli connection reload
sudo systemctl restart NetworkManager
