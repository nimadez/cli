#!/bin/bash
#
# Setup privoxy configs

sudo chown -R $USER:$USER /etc/privoxy/config
cat > /etc/privoxy/config <<EOF

admin-address admin@$(hostname)

listen-address  $(hostname -I | tr -d ' '):8118
#listen-address  [::1]:8118

forward         /  localhost:8118  .
forward-socks5  /  localhost:9050  .
#forward-socks4  /  localhost:9050  .
#forward-socks4a /  localhost:9050  .

toggle  1
enable-remote-toggle  0
enable-remote-http-toggle  0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
forwarded-connect-retries  0
accept-intercepted-requests 0
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
tolerate-pipelining 1
socket-timeout 300
single-threaded 0

confdir /etc/privoxy
logdir /var/log/privoxy
logfile logfile

actionsfile match-all.action
actionsfile default.action
actionsfile user.action
filterfile default.filter
filterfile user.filter
EOF

sudo systemctl stop privoxy.service
sudo systemctl restart privoxy.service
