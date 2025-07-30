#!/bin/bash
#
# Llama-cpp interactive
#
# Optimized for low-end (8-16 GB RAM + 4 GB VRAM)
#
# llama-cpp b6022 compiled with cuda 12.2 on kernel 6.1.0-37
# export GGML_CUDA_ENABLE_UNIFIED_MEMORY=1
# export GGML_CUDA_FORCE_MMQ=true
# export GGML_CUDA_KQUANTS_ITER=1
# -DGGML_CUDA=ON -DLLAMA_CURL=OFF

BIN=/media/$USER/local/apps/llamacpp/llama-cli
MODEL_A="/media/$USER/local/ml/gguf/Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf"
MODEL_B="/media/$USER/local/ml/gguf/Qwen3-8B-UD-Q4_K_XL.gguf"

THREADS=4
LAYERS=20 # offload 20/33 layers, decrease in case of low vram
SYSTEM="You are DEB, an AI assistant. Keep responses short."

echo 1- Meta-Llama-3.1-8B-Instruct-Q4_K_M.gguf
echo 2- Qwen3-8B-UD-Q4_K_XL.gguf \(best with \/no_think\)
read -p "Model: " index

if [ "$index" == 1 ]; then
    MODEL=$MODEL_A
    TEMPLATE="llama3"
elif [ "$index" == 2 ]; then
    MODEL=$MODEL_B
    TEMPLATE="chatml"
fi

$BIN -m "$MODEL" -sys "$SYSTEM" \
    --keep -1 --predict -1 \
    --ctx-size 2048 --batch-size 2048 -ngl $LAYERS \
    --threads $THREADS --threads-batch $THREADS \
    --mlock --flash-attn \
    --repeat-last-n 64 --repeat-penalty 1.1 --mirostat 0 \
    --top-k 40 --top-p 0.9 --min-p 0.0 \
    --seed -1 --temp 0.8 \
    --color --interactive -cnv \
    --chat-template $TEMPLATE
