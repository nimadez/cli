#!/bin/bash

pkg install golang
git clone https://git.torproject.org/pluggable-transports/snowflake.git
cd snowflake/client
go get
go build
cd ~
