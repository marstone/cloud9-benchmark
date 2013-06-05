#!/bin/bash

TARGET=$1
if [ -z "$1" ]; then
	echo "Usage: $0 TARGET [WORKER_NUMS] [BALANCER_IP]"
	exit
fi

NUM=$2
if [ -z "$2" ]; then NUM=2; fi


LB=$3
if [ -z "$3" ]; then LB="127.0.0.1"; fi

if [ NUM -gt 16 ]; then
	NUM=16
fi

echo "NUM is $NUM. initiating..."

for I in $(seq 1 $NUM); do

	DIR=worker-output-$(printf "%02d" $I)

	CMD="$(arch) -R -L c9-worker \
	--stand-alone=false \
	--output-dir=$DIR -c9-lb-host=$LB \
	--c9-local-port=$((19000+I)) \
	$4 $5 $6 $TARGET"
#    	[... other KLEE/Cloud9 parameters ...] &
	echo setarch $CMD
	
	rm -rf $DIR	
	
	time setarch $CMD &

	sleep 0.1
done

echo "done."
