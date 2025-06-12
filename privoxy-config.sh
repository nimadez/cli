#!/bin/bash
#
# Setup privoxy config

ip=$(hostname -I | tr -d ' ')

sudo chown -R $USER:$USER /etc/privoxy/config
cat > /etc/privoxy/config <<EOF

listen-address  $ip:8118
#listen-address  [::1]:8118

forward         /  localhost:8118  .
forward-socks5  /  $ip:9050  .
#forward-socks4  /  localhost:9050  .
#forward-socks4a /  localhost:9050  .

toggle  1
enable-remote-toggle  0
enable-remote-http-toggle  0
enable-edit-actions 0
enable-proxy-authentication-forwarding 0
enforce-blocks 0
buffer-limit 4096
max-client-connections 256
forwarded-connect-retries  0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
tolerate-pipelining 1
socket-timeout 300
single-threaded 0

admin-address admin@$(hostname)
confdir /etc/privoxy
logdir /var/log/privoxy
logfile logfile

actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
filterfile user.filter
EOF
sudo chown -R root:root /etc/privoxy/config

sudo systemctl stop privoxy.service
sudo systemctl restart privoxy.service
echo Privoxy service is [$(systemctl is-active privoxy.service)].
