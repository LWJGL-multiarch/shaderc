#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE[0]}")"

# sudo apt install cmake ninja-build

python3 utils/git-sync-deps

cmake -B build \
    -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_FLAGS="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0" \
    -DSHADERC_SKIP_INSTALL=ON -DSHADERC_SKIP_TESTS=ON
cmake --build build --parallel
strip ./build/libshaderc/libshaderc_shared.so

# Copy result to output directory
LWJGL_OUTPUT_DIR="${LWJGL_OUTPUT_DIR:-/tmp/lwjgl3-build/output}"

mkdir -p "$LWJGL_OUTPUT_DIR"
cp ./build/libshaderc/libshaderc_shared.so "$LWJGL_OUTPUT_DIR/libshaderc.so"
