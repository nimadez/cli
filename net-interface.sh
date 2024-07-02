#!/bin/bash

ip link
read -p "press enter to continue ..." p
sudo nano /etc/network/interfaces
sudo service networking restart
