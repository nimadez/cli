#!/bin/bash
#
# Qwen coder

BIN=/media/$USER/local/apps/llamacpp/llama-cli
MODEL="/media/$USER/local/ml/gguf/Qwen2.5.1-Coder-7B-Instruct-Q4_K_L.gguf"
SYSTEM="You are Qweny, an AI coder. Keep responses short."
THREADS=4
LAYERS=20

$BIN -m "$MODEL" -p "$SYSTEM" \
    --keep -1 --predict -1 \
    --ctx-size 2048 --batch-size 2048 -ngl $LAYERS \
    --threads $THREADS --threads-batch $THREADS \
    --mlock --flash-attn \
    --repeat-last-n 64 --repeat-penalty 1.1 --mirostat 0 \
    --top-k 40 --top-p 0.9 --min-p 0.0 \
    --color \
    --chat-template llama3 --interactive \
    -cnv --seed -1 --temp 0.8
