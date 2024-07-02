#!/bin/bash

# fix undetected ethernet (ethernet and wifi conflict)

echo | sudo tee -a /etc/NetworkManager/NetworkManager.conf
echo "[keyfile]" | sudo tee -a /etc/NetworkManager/NetworkManager.conf
echo "unmanaged-devices=*,except:type:wifi,except:type:wwan,except:type:ethernet" | sudo tee -a /etc/NetworkManager/NetworkManager.conf
