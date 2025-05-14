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
echo - "178.22.122.100, 185.51.200.2"
echo - "185.55.226.26, 185.55.225.25"
echo - "185.231.182.126, 37.152.182.112"
read -p "DNS: " dns

nmcli connection modify $name ipv4.ignore-auto-dns yes
nmcli connection modify $name ipv4.dns "$dns"

sudo nmcli connection reload
sudo systemctl restart NetworkManager
