#!/bin/bash

#DEVICES="/dev/sda /dev/mmcblk0"
DEVICES="/dev/mmcblk0"
BAD_BLK_LOG="./badblocks.log"
BENCHMARK_LOG="./benchmark.log"
MNT="./mount_point"

for DEVICE in $DEVICES
do
	# test blocks
	sudo badblocks -o $BAD_BLK_LOG $DEVICE 

	# test read/write
	sudo mount "$DEVICE"p1 $MNT # always mount partition 1
	ret=$?

	if [[ $ret -eq 0 ]] # successfully mounted
	then
		# sudo ./test_read_write.sh $MNT/loremipsum.txt
		sudo zcat loremipsum.txt.gz > $MNT/loremipsum.txt
		sudo umount "$DEVICE"p1
		sudo mount "$DEVICE"p1 $MNT # assumes that if it worked once it will twice
		echo $(./md5sum_compare.sh loremipsum.txt.md5sum $MNT/loremipsum.txt)
	fi

	# test performance
	# read
	hdparm -t $DEVICE > $BENCHMARK_LOG
	# write
	sudo dd count=1k bs=1M if=/dev/null of=$MNT/nothing.dat

	sudo umount $DEVICE
done
