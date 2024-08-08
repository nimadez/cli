#!/bin/bash

scr=$(realpath "$0")
dir=$(dirname "$scr")
model=/media/$USER/local/ml/stable-diffusion/ckpt/xl/zavychromaxl_v80.safetensors

~/.venv/mdx/bin/python3 $dir/../mental-diffusion/src/mdx.py -t xl -c "$model" "$@"
