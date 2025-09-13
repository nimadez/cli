#!/bin/bash
#
# Get basic network info (support multi-interface)

ACTIVE=$(nmcli -t -f NAME con show --active | head -n 1)

echo "Ethernet     $(ls /sys/class/net | grep ^enp || echo none | xargs)"
echo "Tether       $(ls /sys/class/net | grep ^enx || echo none)"
echo "Wi-Fi        $(ls /sys/class/net | grep ^wlx || echo none)"
echo
echo "Interface    $(ip route list | grep default | awk '{print $5}' | xargs)"
echo "Active       $ACTIVE"
echo
echo "Hostname     $(hostname)"
echo "Domain       $(hostname -d)"
echo "Gateway      $(ip route show default | grep -oP 'via \K\S+' || echo none | xargs)"
echo "Address      $(hostname -I | awk '{print $1}')"
echo "DNS          $(resolvectl status | grep "DNS Servers:" | awk '{$1=$2=""; print $0}' | xargs)"

if [ ! "$ACTIVE" = "lo" ]; then
    echo "WAN Address  $(dig +short txt ch whoami.cloudflare @1.0.0.1 | tr -d '"')"
fi
