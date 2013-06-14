#!/bin/bash

if [ $# -ne 1 ]
	echo "usage: $0 <hostname> [time]"
	exit 65
fi

count=$(sudo ping -i 0 -w $DEADLINE $myHost | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
        echo "Count is $count"
        if [ $count -eq 0 ]; then
                echo "Could not reach host $myHost"
        fi
