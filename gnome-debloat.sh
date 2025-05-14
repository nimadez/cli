#!/bin/bash
#
# A tiny debloater for GNOME

sudo apt -y autoremove --purge  avahi-daemon cups-daemon evince \
                                gnome-software gnome-contacts \
                                system-config-printer-common yelp

systemctl --user mask evolution-addressbook-factory.service
systemctl --user mask evolution-calendar-factory.service
systemctl --user mask evolution-source-registry.service
systemctl --user mask evolution-user-prompter.service
sudo systemctl daemon-reload
