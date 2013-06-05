#!/bin/bash



LOG='/tmp/c9worker.log'
LOCK='/tmp/c9worker.lock'
PID=$$
INFO="[INFO#${PID}]"
DEBUG="[DEBUG#${PID}]"
ERROR="[ERROR#${PID}]"
WORKSPACE=/opt/cloud9/workspace
CLOUD9_ROOT=/opt/cloud9
# read num, balancer, and workload
NUM=$1
if [ -z "$1" ]; then NUM=2; fi


LB=$2
if [ -z "$2" ]; then LB="127.0.0.1"; fi

if [ NUM -gt 16 ]; then
        NUM=16
fi
LB_PORT=$3

TARGET=$4

cd /tmp

echo "c9run-remote.sh started. with lb=$LB:$LB_PORT, target=$TARGET, num-of-workers=$NUM."
#echo "$INFO $(date "+%d/%b/%Y:%H:%M:%S") $0 started" >> $LOG

NUM=$1
if [ -z "$1" ]; then NUM=2; fi
if [ NUM -gt 16 ]; then NUM=16; fi

LB=$2
if [ -z "$2" ]; then LB="127.0.0.1"; fi


echo "NUM is $NUM. LoadBalancer is $LB, initiating..."

for I in $(seq 1 $NUM); do

        DIR=/tmp/worker-output-$(printf "%02d" $I)

        CMD="$(arch) -R -L $CLOUD9_ROOT/src/cloud9/Release+Asserts/bin/c9-worker \
        --output-dir=$DIR -c9-lb-host=$LB -c9-lb-port=$LB_PORT\
        --c9-local-port=$((19000+I)) \
        $WORKSPACE/$TARGET"
#       [... other KLEE/Cloud9 parameters ...] &
        echo setarch $CMD

        rm -rf $DIR

        #time setarch $CMD &
	time $CMD &

        sleep 0.1
done



echo "[C9-REMOTE]c9 remoting jobs started."
