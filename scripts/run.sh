#/bin/bash

IND=3
END=$1

if [ -z "$END" ]; then
	END=5
#	echo "END is $END"
fi

./expand.sh $END

../build/make_all

rm -rf test-ifelse/


llvm-gcc -c --emit-llvm ifelse.c
#time klee ifelse.o

rm -rf klee-*

echo 'done'
