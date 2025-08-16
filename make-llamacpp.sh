#!/bin/bash
#
# Make llama-cpp from source directory

if [ $# -eq 1 ]; then
    export GGML_CUDA_ENABLE_UNIFIED_MEMORY=1
    export GGML_CUDA_FORCE_MMQ=true
    export GGML_CUDA_KQUANTS_ITER=1

    cmake -S $1 -B ./build -DGGML_CUDA=ON -DLLAMA_CURL=OFF
    cd ./build
    make
else
    echo "help: make-llamacpp.sh [src]"
fi
