#!/bin/bash
#
# Query and display logs collected by the systemd-journald service
# including kernel, services, and applications
# (optional filter by string)

if [ $# -eq 1 ]; then
    journalctl | grep -i "$1" | less -X
else
    journalctl -qf
fi
