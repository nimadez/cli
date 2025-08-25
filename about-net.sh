#!/bin/bash
#
# Get basic network info (support multi-interface)

echo "Ethernet(s)  $(ls /sys/class/net | grep ^enp || echo none | xargs)"
echo "Tether       $(ls /sys/class/net | grep ^enx || echo none)"
echo "Wi-Fi        $(ls /sys/class/net | grep ^wlx || echo none)"
echo
echo "Interface(s) $(ip route list | grep default | awk '{print $5}' | xargs)"
echo "Active       $(nmcli -t -f NAME con show --active | head -n 1)"
echo
echo "Hostname     $(hostname)"
echo "Domain       $(hostname -d)"
echo "Gateway(s)   $(ip route show default | grep -oP 'via \K\S+' | xargs)"
echo "Addresses    $(hostname -I)"
echo "DNS(s)       $(resolvectl status | grep "DNS Servers:" | awk '{$1=$2=""; print $0}' | xargs)"
