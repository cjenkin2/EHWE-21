#!/bin/bash

# otherwise system memory
# is filled with .dot and .png files
make clean

VIDS=$(ls $(pwd)/clips/*)

for VID in $VIDS
do
	echo "VID is $VID"
	./test_decoder_totem.sh $VID
done
