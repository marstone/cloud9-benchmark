#!/bin/bash

PATH0=$PATH
export PATH=~/llvm/llvm-3.1/Release+Asserts/bin:~/binutils/install/bin:$PATH

TARGET=$1

clang -emit-llvm -I$HOME/cloud9/src/include -c -o $TARGET.o $TARGET.c

clang++ -emit-llvm -flto -Wl,-plugin-opt=also-emit-llvm -o $TARGET -Wl,--start-group $TARGET.o -Wl,--end-group $2 $3 $4 $5

export PATH=$PATH0
gcc -L $HOME/cloud9/src/Release+Asserts/lib -I$HOME/cloud9/src/include $TARGET.c -lkleeRuntest -lglog -o $TARGET.gcc
#gcc -L $HOME/cloud9/src/Release+Asserts/lib -I$HOME/cloud9/src/include hello3.c -lkleeRuntest -o $TARGET.gcc

