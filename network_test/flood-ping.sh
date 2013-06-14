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

STATUS_MSG=$(sudo ping -i 0 -w $DEADLINE $HOSTNAME | grep 'received')
COUNT=$(echo $STATUS_MSG | awk -F',' '{ print $2 }' | awk '{ print $1 }')
echo "ping: $STATUS_MSG" > flood-ping.log

if [ "$STATUS_MSG" = "" ]; then
	COUNT=0
fi

if [ $COUNT -eq 0 ]; then
        echo "Could not reach host $HOSTNAME!"
	exit 1
fi
