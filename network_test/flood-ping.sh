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

count=$(sudo ping -i 0 -w $DEADLINE $HOSTNAME | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
        echo "Count is $count"
        if [ $count -eq 0 ]; then
                echo "Could not reach host $myHost"
        fi
