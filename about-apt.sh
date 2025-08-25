#!/bin/bash
#
# Get the number, list and history of available packages

while true; do

echo "0. All Debian packages   $(apt list 2>/dev/null | wc -l)+"
echo "1. Installed (total)     $(apt list --installed 2>/dev/null | wc -l)"
echo "2. Installed (auto)      $(apt-mark showauto | wc -l)"
echo "3. Installed (manual)    $(apt-mark showmanual | wc -l)"
echo "4. ├─ Backports          $(dpkg-query -W | grep -c '~bpo')"
echo "5. ├─ Contrib            $(dpkg-query -W -f='${Section}\t${Package}\n' | grep -c ^contrib)"
echo "6. ├─ Non-free           $(dpkg-query -W -f='${Section}\t${Package}\n' | grep -c ^non-free)"
echo "7. ├─ Non-free-firmware  $(dpkg-query -W -f='${Section}\t${Package}\n' | grep -c ^non-free-firmware)"
echo "8. └─ i386               $(dpkg -l | grep -c i386)"
echo "H. History               $(cat /var/log/apt/history.log | grep -c ^Start-Date)"
echo "F. Find packages"
read -p ":  " p
echo

if [ "$p" = "0" ]; then
    apt list 2>/dev/null
elif [ "$p" = "1" ]; then
    apt list --installed 2>/dev/null
elif [ "$p" = "2" ]; then
    apt-mark showauto | less -X
elif [ "$p" = "3" ]; then
    apt-mark showmanual | less -X
elif [ "$p" = "4" ]; then
    dpkg-query -W | grep '~bpo' | less -X
elif [ "$p" = "5" ]; then
    dpkg-query -W -f='${Section}\t${Package}\n' | grep ^contrib | less -X
elif [ "$p" = "6" ]; then
    dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free | less -X
elif [ "$p" = "7" ]; then
    dpkg-query -W -f='${Section}\t${Package}\n' | grep ^non-free-firmware | less -X
elif [ "$p" = "8" ]; then
    dpkg -l | grep i386 | less -X
elif [[ "$p" = "h" || "$p" = "H" ]]; then
    cat /var/log/apt/history.log | less -X
elif [[ "$p" = "f" || "$p" = "F" ]]; then
    read -p "String: " str
    apt list --installed 2>/dev/null | grep "$str" | less -X
else
    exit 0
fi

echo
done
