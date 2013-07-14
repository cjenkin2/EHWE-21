#!/bin/bash

if [ $# -eq 1 ]
then
	DEVICE=$1
else
	DEVICE="/dev/mmcblk0p3"
fi

MNT="./mount_point"

./badblocks_test.sh $DEVICE
./filesystem_test.sh $DEVICE $MNT
./benchmark_test.sh $DEVICE $MNT

# just in case
sudo umount "$DEVICE"
