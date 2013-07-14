#!/bin/bash

if [ $# -ne 2 ]
then
        echo "usage: $0 <device_filesystem> <mount_point>"
        exit 65 # bad arguments
fi

DEVICE=$1
MNT=$2

# test read/write

echo $(date) >> filesystem.log

# sudo ./test_read_write.sh $MNT/loremipsum.txt
zcat loremipsum.txt.gz > $MNT/loremipsum.txt
echo "md5sum_compare.sh: " $(./md5sum_compare.sh loremipsum.txt.md5sum $MNT/loremipsum.txt) | tee -a filesystem.log | cat
echo "--------------------------------------------------------------------------------" >> filesystem.log

#cleanup
sudo rm $MNT/loremipsum.txt
