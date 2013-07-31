#!/bin/bash

if [ $# -ne 2 ]
then
	echo "usage: $0 <device> <mount_point>"
	exit 65 # bad params
fi

DEVICE=$1
MNT=$2

echo "----------------------------------------" >> benchmark.log
echo $(date)                                    >> benchmark.log

# write
echo "Testing write speeds" | tee -a benchmark.log
dd count=1k bs=1M if=/dev/zero of=$MNT/nothing.dat >> benchmark.log 2>&1

# read
echo "Testing read speeds" | tee -a benchmark.log
dd count=1k bs=1M if=$MNT/nothing.dat of=/dev/null >> benchmark.log 2>&1

#cleanup
rm $MNT/nothing.dat
