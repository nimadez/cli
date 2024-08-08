#!/bin/bash

scr=$(realpath "$0")
dir=$(dirname "$scr")

~/.venv/mdx/bin/python3 $dir/../mental-diffusion/src/addons/mdx-upscale.py "$@"
