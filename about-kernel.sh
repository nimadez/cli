#!/bin/bash
#
# Get the kernel log and check for possible errors

while true; do

echo "Kernel $(uname -r)"
echo
echo "8. Emergency    $(sudo dmesg --level=emerg | wc -l)"
echo "7. Alert        $(sudo dmesg --level=alert | wc -l)"
echo "6. Critical     $(sudo dmesg --level=crit | wc -l)"
echo "5. Error        $(sudo dmesg --level=err | wc -l)"
echo "4. Warning      $(sudo dmesg --level=warn | wc -l)"
echo "3. Notice       $(sudo dmesg --level=notice | wc -l)"
echo "2. Information  $(sudo dmesg --level=info | wc -l)"
echo "1. Debug        $(sudo dmesg --level=debug | wc -l)"
echo "0. All          $(sudo dmesg | wc -l)"
echo "W. Watch"
read -p ":  " p
echo

if [ "$p" = "8" ]; then
    sudo dmesg --level=emerg | less -X
elif [ "$p" = "7" ]; then
    sudo dmesg --level=alert | less -X
elif [ "$p" = "6" ]; then
    sudo dmesg --level=crit | less -X
elif [ "$p" = "5" ]; then
    sudo dmesg --level=err | less -X
elif [ "$p" = "4" ]; then
    sudo dmesg --level=warn | less -X
elif [ "$p" = "3" ]; then
    sudo dmesg --level=notice | less -X
elif [ "$p" = "2" ]; then
    sudo dmesg --level=info | less -X
elif [ "$p" = "1" ]; then
    sudo dmesg --level=debug | less -X
elif [ "$p" = "0" ]; then
    sudo dmesg | less -X
elif [ "$p" = "w" -o "$p" = "W" ]; then
    sudo dmesg -w
else
    exit 0
fi

echo
done
