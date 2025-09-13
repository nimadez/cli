#!/bin/bash
#
# A fast AI assistant and coder that only relies on CPU (optional GPU/CUDA)
# llama-cpp: b6316
#
# - CPU mode is very fast with minimal memory usage, no need for CUDA
# - Without thinking or extra chit-chat, just gives the answer/code
# - The result can be piped into a program, as it is clean
# - Special characters can be used to some extent
#
# Notice: Do not wrap entire prompt in quotes, but wrap code in single quotes ('').
#
# $ codex a multi-dimensional iteration with awk in bash
# $ codex a python to remove first line of string
# $ codex a javascript to convert rgb to hex
# $ codex 2.5% of 80,000,000
# $ codex eiffel tower is in ...
# $ codex does charging a lithium battery up to 80% extend its lifespan?
# $ codex explain this: 'return "#" + [r, g, b].map(x => x.toString(16).padStart(2, "0")).join("");'
#
# GPU mode can be easily enabled by running the 'codexx' instead of codex.
# If you are using the same build for both CPU and GPU, just set both to the same.
# (but llama-cpp usually uses GPU in CPU mode somewhat)

BIN="/media/$USER/local/apps/llama-cpp/build-cpu/bin/llama-cli"
BIN_GPU="/media/$USER/local/apps/llama-cpp/build-gpu/bin/llama-cli"
MODEL="/media/$USER/local/ml/gguf/Qwen3-8B-UD-Q4_K_XL.gguf"
USE_GPU=0
GPU_LAYERS=20

if [ $# -gt 0 ]; then
    set -f
    ARG=""
    for arg in "$@"; do
        escaped=$(printf '%s' "$arg" | sed "s/'/'\\\\''/g; s/[^a-zA-Z0-9._-]/\\\\&/g")
        ARG="$ARG$escaped "
    done
    set +f

    # use half threads for processing
    THREADS=$(($(nproc) / 2))

    # keep the model in memory if there is enough RAM (swap is not usually used)
    MLOCK=""
    if [ "$(free | grep Mem | awk '{print $2}')" -gt 8500000 ]; then
        MLOCK="--mlock"
    fi

    # optional gpu support
    GPU="--n-gpu-layers 0"
    if [ "$USE_GPU" -eq 1 ]; then
        BIN="$BIN_GPU"
        GPU="--n-gpu-layers $GPU_LAYERS --flash-attn"
    fi

    MSG=$($BIN -m "$MODEL" -p "$ARG" \
        -sys "You are Codex, an AI assistant and coder. Keep responses short. /no_think" \
        --threads $THREADS --threads-batch $THREADS $GPU \
        --ctx-size 2048 --batch-size 1024 --ubatch-size 512 $MLOCK \
        --seed -1 --temp 0.7 --top-k 30 --top-p 0.9 --min-p 0.05 \
        --chat-template chatml --conversation --single-turn --no-warmup \
        --no-display-prompt --escape --offline 2>/dev/null)

    MSG=$(echo "$MSG" | sed 's/ \[end of text\]//g' | tail -n +5)

    printf "\033[96m%s\033[0m\n" "$MSG"
else
    echo "Usage: codex.sh [prompt]"
fi
