#!/bin/bash

if [ $# -ne 2 ]
then
        echo "usage: $0 <device_filesystem> <mount_point>"
        exit 65 # bad arguments
fi

DEVICE=$1
MNT=$2

sudo umount "$DEVICE"

# test read/write
sudo mount $DEVICE $MNT
ret=$?

echo $(date) >> filesystem.log

echo "Tried to mount $DEVICE on $MNT: $ret" | tee -a filesystem.log | cat

if [[ $ret -eq 0 ]] # successfully mounted
then
	# sudo ./test_read_write.sh $MNT/loremipsum.txt
	sudo chmod 666 $MNT/*
	sudo bash -c "zcat loremipsum.txt.gz > $MNT/loremipsum.txt"
	sudo umount "$DEVICE"
	sudo mount "$DEVICE" $MNT # assumes that if it worked once it will twice
	echo $(sudo ./md5sum_compare.sh loremipsum.txt.md5sum $MNT/loremipsum.txt) | tee -a filesystem.log | cat
	echo "--------------------------------------------------------------------------------" >> filesystem.log

	#cleanup
	sudo rm $MNT/loremipsum.txt
fi

sudo umount $DEVICE
