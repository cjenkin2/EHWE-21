#!/bin/bash

if [ $# -ne 2 ]
then
	echo "usage: $0 <device> <mount_point>"
	exit 65 # bad params
fi

DEVICE=$1
MNT=$2

# write
echo "Testing write speeds" | tee -a benchmark.log
dd count=1k bs=1M if=/dev/zero of=$MNT/nothing.dat >> benchmark.log

# read
echo "Testing read speeds" | tee -a benchmark.log
dd count=1k bs=1M if=$MNT/nothing.dat of=/dev/null >> benchmark.log

#cleanup
rm $MNT/nothing.dat
