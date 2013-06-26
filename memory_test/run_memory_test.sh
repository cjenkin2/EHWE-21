#!/bin/bash

#DEVICES="/dev/sda /dev/mmcblk0"
DEVICES="/dev/mmcblk0"
BAD_BLK_LOG="./badblocks.log"
MNT="./mount_point"


# test for bad blocks in devices
for DEVICE in $DEVICES
do
	sudo badblocks -o $BAD_BLK_LOG $DEVICE 

	sudo mount $DEVICE $MNT
	ret=$?

	if [[ $ret -eq 0 ]] # successfully mounted
	then
		./test_read_write.sh
	fi

	sudo umount $DEVICE
done
