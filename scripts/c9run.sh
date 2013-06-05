#!/bin/bash

LOG="/tmp/c9.log"
DIR_WORKSPACE="/opt/cloud9/workspace"
DIR_C9ROOT="/opt/cloud9"
CMD_RUN_REMOTE="c9run-remote.sh"
CMD_RUN_WORKER="c9run-worker.sh"

echo "loading c9config..."
source c9config.sh
echo "config loaded."

ERR1="unknown error."
ERR2="bad parameter."

ErrorExit() 
{
	echo 'error, exit.' $1
}

COUNT=0
CheckConfig() 
{
	echo 'checking config..'
	while [ -n "$WORKER" ]
	do
		I=$COUNT
		COUNT=$(( $COUNT+1 ))
		WORKER=${WORKER[$I]}
		WORKER_IP[$I]=$(echo $WORKER | grep -Eo '.+,' | grep -Eo '(\w|\.|-)+' )
		WORKER_NO[$I]=$(echo $WORKER | grep -Eo ',[0-9]+' | grep -Eo '([0-9])+' )
		echo "WORKER_IP[$I]=${WORKER_IP[$I]},WORKER_NO[$I]=${WORKER_NO[$I]}"
		if [ -z "${WORKER_IP[$I]}" ] || [ -z "${WORKER_NO[$I]}" ]; then
			COUNT=-1
			ErrorExit $ERR2
		fi
		WORKER=${WORKER[$COUNT]}
	done
	
	echo Load Balancer is $BALANCER
        BALANCER_IP=$(echo $BALANCER | grep -Eo '.+:' | grep -Eo '(\w|\.|-)+' )
        BALANCER_PORT=$(echo $BALANCER | grep -Eo ':[0-9]+' | grep -Eo '([0-9])+' )
	echo Samba Path is $SAMBA_PATH
	echo Samba User is $SAMBA_USER

	echo 'Samba Pass is ********(hidden).'
	echo "COUNT=$COUNT"
}

Wait() 
{
	echo "Waiting all remote commands finishing..."
	CMD_REMOTE_ACTIVE=$CMD_RUN_WORKER
	while [ "$CMD_REMOTE_ACTIVE" = "$CMD_RUN_WORKER" ]; do

		# if [ "$CMD_REMOTE_ACTIVE" = "$CMD_RUN_REMOTE" ]; then

		echo "[$(date)]not done... sleep 3000 million-seconds...waiting for all \"$CMD_REMOTE_ACTIVE\" completing... "
		sleep 3

		CMD_REMOTE_ACTIVE=$(ps aux | grep -v "vi " | grep -v grep | grep -Eo $CMD_RUN_WORKER | head -n1)
	done
}

CheckConfig

killall c9-lb
# start load balancer.
echo "[M]start load balancer... TODO:CHANGE to server machine"
time $DIR_C9ROOT/src/cloud9/Release+Asserts/bin/c9-lb &
echo "[M]balancer started. waiting 1 second."
sleep 1

for I in $(seq 0 $(( $COUNT-1 ))); do

	CMD_MOUNT="echo $SAMBA_PASS | sudo -S mount -t cifs -o user=$SAMBA_USER,password=$SAMBA_PASS $SAMBA_PATH $DIR_WORKSPACE"
	# CMD_UMOUNT="cd && sudo umount $DIR_WORKSPACE;"
	# umount should be done by the $CMD_RUN_REMOTE
	# CMD_C9RUN="$DIR_WORKSPACE/scripts/$CMD_RUN_REMOTE"
	

	echo waiting ${WORKER_IP[$I]} mounting samba...
	CMD="ssh -t ${WORKER_IP[$I]} "$CMD_MOUNT""
	$CMD
	sleep 0.5
	echo ${WORKER_IP[$I]} mounted.
	
	# CMD="ssh -t ${WORKER_IP[$I]} \"$CMD_C9RUN\"&"
	CMD="bash $CMD_RUN_WORKER ${WORKER_IP[$I]} ${WORKER_NO[$I]} $BALANCER_IP $BALANCER_PORT $TARGET"
	#CMD="echo abcde..."
	echo $CMD
	$CMD &
done

echo '[M]all worker started. waiting for join. sleep 1.'
sleep 1

Wait

for I in $(seq 0 $(( $COUNT-1 ))); do

        echo waiting ${WORKER_IP[$I]} umounting samba...
        CMD_UMOUNT="echo $SAMBA_PASS | sudo -S umount $DIR_WORKSPACE"
        CMD="ssh -t ${WORKER_IP[$I]} "$CMD_UMOUNT""
        $CMD        
        sleep 0.5
        echo ${WORKER_IP[$I]} umounted.
done

for I in $(seq 0 $(( $COUNT-1 ))); do

        echo waiting ${WORKER_IP[$I]} clearing data...
        CMD_CLEAR="echo $SAMBA_PASS | sudo -S rm -rf /tmp/worker-output-*"
        CMD="ssh -t ${WORKER_IP[$I]} "$CMD_CLEAR""
        $CMD
        sleep 0.5
        echo ${WORKER_IP[$I]} worker-output-* cleared.
done

echo "[M]main thread $0 done. all complete."
