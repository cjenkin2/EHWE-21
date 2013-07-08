#!/bin/bash

if [ $# -ne 1 ]
then
	echo "usage: $0 <device_filesystem>"
	echo "e.g. $0 /dev/mmcblk0p3"
	exit 65 # bad arguments
fi

DEVICE=$1
MNT="./mount_point"

./badblocks_test.sh $DEVICE
./filesystem_test.sh $DEVICE $MNT
./benchmark_test.sh $DEVICE $MNT

# just in case
sudo umount "$DEVICE"
