#!/bin/bash
#
# Llama-cpp server

BIN=/media/$USER/local/apps/llamacpp/llama-server
MODEL="/media/$USER/local/ml/gguf/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf"
THREADS=4
LAYERS=20

$BIN -m "$MODEL" \
    --keep -1 --predict -1 \
    --ctx-size 2048 --batch-size 2048 -ngl $LAYERS \
    --threads $THREADS --threads-batch $THREADS \
    --mlock --flash-attn \
    --repeat-last-n 64 --repeat-penalty 1.1 --mirostat 0 \
    --top-k 40 --top-p 0.9 --min-p 0.0 \
    --chat-template llama3 --no-escape \
    --host 0.0.0.0 --port 8012
