#!/bin/bash
#
# Install ClamAV antivirus (clamscan only, no daemon)

sudo apt install --no-install-recommends clamav

# disable automatic update (the database is updated before each scan)
sudo systemctl stop clamav-freshclam.service
sudo systemctl disable clamav-freshclam.service

echo "done"

# configure database mirror
# $ sudo nano /etc/clamav/freshclam.conf
#DatabaseMirror db.<country code>.clamav.net
