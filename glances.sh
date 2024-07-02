#!/bin/bash

export http_proxy=" "
export https_proxy=" "

~/.venv/glances/bin/python3 ~/.venv/glances/bin/glances --disable-check-update --disable-autodiscover --disable-webui --disable-cursor
