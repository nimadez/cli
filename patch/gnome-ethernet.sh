#!/bin/bash
#
# Fix undetected ethernet

sudo bash -c 'cat > /etc/NetworkManager/NetworkManager.conf << EOF
[main]
plugins=ifupdown,keyfile

[ifupdown]
managed=false

[keyfile]
unmanaged-devices=*,except:type:wifi,except:type:wwan,except:type:ethernet
EOF'

sudo service NetworkManager restart

echo "done"
