#!/bin/bash

if [ $# -ne 1 ]
then
	echo "usage: $0 <device>"
	exit 65 # bad arguments
fi

#DEVICES="/dev/sda /dev/mmcblk0"
BAD_BLK_LOG="./badblocks.log"
BENCHMARK_LOG="./benchmark.log"
MNT="./mount_point"
DEVICE=$1

	sudo umount "$DEVICE"

	# test blocks
	echo $(date) >> $BAD_BLK_LOG
#	sudo badblocks -o $BAD_BLK_LOG $DEVICE
	echo "------------------------------" >> $BAD_BLK_LOG 

	# test read/write
	sudo mount $DEVICE $MNT 
	ret=$?

	echo "Tried to mount $DEVICE on $MNT: $ret"

	if [[ $ret -eq 0 ]] # successfully mounted
	then
		# sudo ./test_read_write.sh $MNT/loremipsum.txt
		sudo chmod 666 $MNT/*
		sudo bash -c "zcat loremipsum.txt.gz > $MNT/loremipsum.txt"
		sudo umount "$DEVICE"
		sudo mount "$DEVICE" $MNT # assumes that if it worked once it will twice
		echo $(sudo ./md5sum_compare.sh loremipsum.txt.md5sum $MNT/loremipsum.txt)	# read
		sudo hdparm -t $DEVICE >> $BENCHMARK_LOG
		# write
		sudo dd count=1k bs=1M if=/dev/zero of=$MNT/nothing.dat >> $BENCHMARK_LOG
	fi

	# test performance

	sudo umount "$DEVICE"
