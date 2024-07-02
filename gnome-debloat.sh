#!/bin/bash

sudo apt -y autoremove --purge avahi-daemon # bonjur, not sharing files via webdav
sudo apt -y autoremove --purge cups-daemon # printer service
sudo apt -y autoremove --purge gnome-contacts # who store contacts on desktop?
sudo apt -y autoremove --purge gnome-software # apt is enough
sudo apt -y autoremove --purge system-config-printer-common
sudo apt -y autoremove --purge yelp

systemctl --user mask evolution-addressbook-factory.service
systemctl --user mask evolution-calendar-factory.service
systemctl --user mask evolution-source-registry.service
systemctl --user mask evolution-user-prompter.service
sudo systemctl daemon-reload
