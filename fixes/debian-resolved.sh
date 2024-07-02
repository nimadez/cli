#!/bin/bash

# install systemd-resolved DNS resolver

sudo apt install systemd-resolved
sudo systemctl enable systemd-resolved
sudo systemctl restart systemd-resolved
