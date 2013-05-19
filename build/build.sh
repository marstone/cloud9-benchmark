#!/bin/bash

export PATH=~/llvm/llvm-3.1/Release+Asserts/bin:~/binutils/install/bin:$PATH
TARGET=$1
clang -emit-llvm -I../../src/include -c -o $TARGET.o $TARGET.c
clang++ -emit-llvm -flto -Wl,-plugin-opt=also-emit-llvm -o $TARGET -Wl,--start-group $TARGET.o -Wl,--end-group -v
