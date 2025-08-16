#!/bin/bash
#
# Notice: This is dangerous and should not be done regularly.

sudo apt -y install fwupd
fwupdmgr get-updates

# If updates are available for any devices on the system
read -p "press enter to update firmware ..." p
fwupdmgr update
