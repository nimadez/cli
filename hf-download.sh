#!/bin/bash
#
# Download a HuggingFace repository

if [ $# -eq 1 ]; then
    ~/.venv/mdx/bin/huggingface-cli download "$1"
else
    echo help: hf-download.sh [repo_id]
fi
