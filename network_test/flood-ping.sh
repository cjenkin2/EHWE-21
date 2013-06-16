#!/bin/bash

if [[ ($# -ne 1) && ($# -ne 2) ]]; then
	echo "usage: $0 <hostname> [time]"
	exit 65
fi

HOSTNAME=$1
if [[ $# -eq 1 ]]; then
	DEADLINE=60
else
	DEADLINE=$2
fi

#ping test
#attribution: www.cyberciti.biz/tips/simple-linux-and-unix-system-monitoring-with-ping-command-and-scripts.html
OUTPUT=$(sudo ping -v -i 0 -w $DEADLINE $HOSTNAME)
SUMMARY=$(echo "$OUTPUT" | grep 'received')
COUNT=$(echo $SUMMARY | awk -F',' '{ print $2 }' | awk '{ print $1 }')

echo "------------------------------------------------------" >> flood-ping.log
echo $(date) >> flood-ping.log
echo "$OUTPUT" >> flood-ping.log

if [ "$SUMMARY" = "" ]; then
	COUNT=0
fi

if [ $COUNT -eq 0 ]; then
        echo "Could not reach host $HOSTNAME!"
	exit 1
fi
