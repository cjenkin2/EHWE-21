#!/bin/bash

if [ $# -ne 1 ]
then
	echo "usage: $0 <device>"
	exit 65 # bad params
fi

DEVICE=$1

# test blocks
echo $(date) >> badblocks.log
sudo badblocks -o badblocks.log $DEVICE
echo "------------------------------" >> badblocks.log
