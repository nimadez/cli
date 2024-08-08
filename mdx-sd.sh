#!/bin/bash

scr=$(realpath "$0")
dir=$(dirname "$scr")
model=/media/$USER/local/ml/stable-diffusion/ckpt/juggernaut_aftermath.safetensors

~/.venv/mdx/bin/python3 $dir/../mental-diffusion/src/mdx.py -t sd -c "$model" -w 512 -h 512 "$@"
