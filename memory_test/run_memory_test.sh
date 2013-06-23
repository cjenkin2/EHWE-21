#!/bin/bash

DEVICES="/dev/sda /dev/mmcblk0"
BAD_BLK_LOG="./badblocks.log"

# test for bad blocks in devices
for DEVICE in $DEVICES
do
	sudo badblocks -o $BAD_BLK_LOG $DEVICE 
done
