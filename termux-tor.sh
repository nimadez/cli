#!/bin/bash

pkg install git
pkg install golang
pkg install obfs4proxy
git clone https://git.torproject.org/pluggable-transports/snowflake.git
cd snowflake/client
go get
go build
cd $HOME
