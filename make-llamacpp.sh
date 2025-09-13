#!/bin/bash
#
# Make llama-cpp from source directory

if [ $# -eq 2 ]; then

    if [ "$1" = "cpu" ]; then

        cmake -S "$2" -B ./build-cpu -DCMAKE_CXX_FLAGS="-O3 -march=native -mtune=native -mavx2" -DGGML_CUDA=OFF -DLLAMA_CURL=OFF
        cd ./build-cpu

    elif [ "$1" = "gpu" ]; then

        export GGML_CUDA_ENABLE_UNIFIED_MEMORY=1
        export GGML_CUDA_FORCE_MMQ=true
        export GGML_CUDA_KQUANTS_ITER=1
        cmake -S "$2" -B ./build-gpu -DCMAKE_CXX_FLAGS="-O3 -march=native -mtune=native -mavx2" -DGGML_CUDA=ON -DLLAMA_CURL=OFF
        cd ./build-gpu
        
    else
        echo "Invalid device (cpu/gpu)."
        exit 1
    fi
    
    make
else
    echo "Usage: make-llamacpp.sh [cpu|gpu] [src-directory]"
fi
