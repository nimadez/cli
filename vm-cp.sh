#!/bin/bash
#
# Copy a file/directory to/from VM using SSH
#
# If you are running this on a host machine for a host-to-guest connection,
# you will need to enter the forwarded ssh port, and you need to have this
# script installed on the guest machine as well,
# But a port is not required for guest-to-host connection.
#
# [guest-to-host connection: send and receive to/from host]
# $ vm-cp.sh [args...]
#
# [host-to-guest connection: send and receive to/from guest]
# $ vm-cp.sh 5555
# $ vm-cp.sh [args...]
# $ vm-cp.sh [args...]
# $ exit

if systemd-detect-virt >/dev/null; then

    if [ $# -eq 4 ]; then
        HOST="$1"
        GUEST="$USER@$(hostname -I | awk '{print $1}')"
        DIRECT="$2"

        case "$DIRECT" in
            "in")  scp -r "$HOST:$3"  "$GUEST:$4" ;;
            "out") scp -r "$GUEST:$3" "$HOST:$4"  ;;
            *) echo "Invalid direction (in/out)."; exit 1 ;;
        esac
    else
        echo "Virtual machine is detected, runs in guest mode."
        echo "Usage: vm-cp.sh [user@host] [in|out] [src] [dest]"
    fi

else

    if [ $# -eq 1 ]; then
        HOST="$USER@$(hostname -I | awk '{print $1}')"
        ssh -p "$1" "$HOST"
    else
        echo "Virtual machine is not detected, runs in host mode."
        echo "Usage: vm-cp.sh [ssh_forwarded_port]"
    fi
    
fi
