#!/bin/bash
#
# Fix undetected ethernet (ethernet and wifi conflict)

sudo bash -c 'cat > /etc/NetworkManager/NetworkManager.conf << EOF
[main]
plugins=ifupdown,keyfile

[ifupdown]
managed=false

[keyfile]
unmanaged-devices=*,except:type:wifi,except:type:wwan,except:type:ethernet
EOF'

echo done
