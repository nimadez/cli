#!/bin/bash
#
# Get the number and list of available packages

echo "Total: $(apt list 2>/dev/null | wc -l)"
echo "Auto: $(apt-mark showauto | wc -l)"
echo "Installed: $(apt list --installed 2>/dev/null | wc -l)"
echo "Backports: $(dpkg-query -W | grep '~bpo' | wc -l)"
echo "Contrib: $(dpkg-query -W -f='${Section}\t${Package}\n' | grep ^contrib | wc -l)"
echo "Non-free: $(dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free | wc -l)"
echo "Non-free-firmware: $(dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free-firmware | wc -l)"
echo "i386: $(dpkg -l | grep i386 | wc -l)"
echo "------------------------------------"

if [ "$1" = "all" ]; then
    apt list | less -M -X
elif [ "$1" = "auto" ]; then
    apt-mark showauto | less -M -X
elif [ "$1" = "installed" ]; then
    apt list --installed | less -M -X
elif [ "$1" = "backports" ]; then
    dpkg-query -W | grep '~bpo' | more
elif [ "$1" = "contrib" ]; then
    dpkg-query -W -f='${Section}\t${Package}\n' | grep ^contrib | more
elif [ "$1" = "non-free" ]; then
    dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free | more
elif [ "$1" = "non-free-firmware" ]; then
    dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free-firmware | more
elif [ "$1" = "i386" ]; then
    dpkg -l | grep i386 | more
else
    echo "help: apt-list.sh [all, auto, installed, backports, contrib, non-free, non-free-firmware, i386]"
fi
