#!/bin/bash

DEVICE=$(mount | grep " / " | cut -d" " -f-1)
MNT="/"

if [ -z "$(echo $DEVICE | grep 'ubi')" ]
then
	:
else
	DEVICE=$(./ubi_device_parse.sh $DEVICE)
fi

./badblocks_test.sh $DEVICE
./filesystem_test.sh $DEVICE $MNT
./benchmark_test.sh $DEVICE $MNT
