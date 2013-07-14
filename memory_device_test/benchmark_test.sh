#!/bin/bash

if [ $# -ne 2 ]
then
	echo "usage: $0 <device> <mount_point>"
	exit 65 # bad params
fi

DEVICE=$1
MNT=$2

hdparm -t $DEVICE >> benchmark.log

# mount to filesystem and write
dd count=1k bs=1M if=/dev/zero of=$MNT/nothing.dat >> benchmark.log

#cleanup
rm $MNT/nothing.dat
