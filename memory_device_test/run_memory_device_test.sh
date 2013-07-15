#!/bin/bash

DEVICE=$(mount | grep " / " | cut -d" " -f-1)
MNT="/"

./badblocks_test.sh $DEVICE
./filesystem_test.sh $DEVICE $MNT
./benchmark_test.sh $DEVICE $MNT
