#!/bin/bash
#
# Get the number, list and history of available packages

DEBIAN=$(apt list 2>/dev/null | tail -n +2)
INST_TOTAL=$(apt list --installed 2>/dev/null | tail -n +2)
INST_AUTO=$(apt-mark showauto)
INST_MANUAL=$(apt-mark showmanual)
INST_BPO=$(dpkg-query -W | grep '~bpo')
INST_CONTRIB=$(dpkg-query -W -f='${Section}\t${Package}\n' | grep ^contrib)
INST_NONFREE=$(dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free)
INST_NONFREE_FIRM=$(dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free-firmware)
INST_I386=$(dpkg -l | grep i386)
HISTORY=$(cat /var/log/apt/history.log)

while true; do

echo "0. All Debian packages    $(echo "$DEBIAN" | grep -v '^$' | wc -l)+"
echo "1. Installed packages     $(echo "$INST_TOTAL" | grep -v '^$' | wc -l)"
echo "2. ├─ Auto Install        $(echo "$INST_AUTO" | grep -v '^$' | wc -l)"
echo "3. ├─ Manual Install      $(echo "$INST_MANUAL" | grep -v '^$' | wc -l)"
echo "4. ├─ Backports           $(echo "$INST_BPO" | grep -v '^$' | wc -l)"
echo "5. ├─ Contrib             $(echo "$INST_CONTRIB" | grep -v '^$' | wc -l)"
echo "6. ├─ Non-free            $(echo "$INST_NONFREE" | grep -v '^$' | wc -l)"
echo "7. ├─ Non-free-firmware   $(echo "$INST_NONFREE_FIRM" | grep -v '^$' | wc -l)"
echo "8. └─ i386                $(echo "$INST_I386" | grep -v '^$' | wc -l)"
echo "H. History                $(echo "$HISTORY" | grep -c ^Start-Date)"
echo "F. Find packages"
read -p ":  " p
echo

if [ "$p" = "0" ]; then
    echo "$DEBIAN" | less -X
elif [ "$p" = "1" ]; then
    echo "$INST_TOTAL" | less -X
elif [ "$p" = "2" ]; then
    echo "$INST_AUTO" | less -X
elif [ "$p" = "3" ]; then
    echo "$INST_MANUAL" | less -X
elif [ "$p" = "4" ]; then
    echo "$INST_BPO" | less -X
elif [ "$p" = "5" ]; then
    echo "$INST_CONTRIB" | less -X
elif [ "$p" = "6" ]; then
    echo "$INST_NONFREE" | less -X
elif [ "$p" = "7" ]; then
    echo "$INST_NONFREE_FIRM" | less -X
elif [ "$p" = "8" ]; then
    echo "$INST_I386" | less -X
elif [[ "$p" = "h" || "$p" = "H" ]]; then
    echo "$HISTORY" | less -X
elif [[ "$p" = "f" || "$p" = "F" ]]; then
    read -p "String: " str
    echo "$INST_TOTAL" | grep "$str" | less -X
else
    exit 0
fi

echo
done
