#!/bin/bash
#
# Llama-cpp server

BIN=/media/$USER/local/apps/llamacpp/llama-server
MODEL_A="/media/$USER/local/ml/gguf/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf"
MODEL_B="/media/$USER/local/ml/gguf/Qwen3-8B-UD-Q4_K_XL.gguf"

THREADS=4
LAYERS=20

echo 1- Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf
echo 2- Qwen3-8B-UD-Q4_K_XL.gguf \(best with \/no_think\)
read -p "Model: " index

if [ "$index" == 1 ]; then
    MODEL=$MODEL_A
elif [ "$index" == 2 ]; then
    MODEL=$MODEL_B
fi

$BIN -m "$MODEL" \
    --keep -1 --predict -1 \
    --ctx-size 2048 --batch-size 2048 -ngl $LAYERS \
    --threads $THREADS --threads-batch $THREADS \
    --mlock --flash-attn \
    --repeat-last-n 64 --repeat-penalty 1.1 --mirostat 0 \
    --top-k 40 --top-p 0.9 --min-p 0.0 \
    --no-escape \
    --host 0.0.0.0 --port 8080
