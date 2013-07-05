#!/bin/bash

VIDS=$(ls $(pwd)/clips/*)

for VID in $VIDS
do
	echo "VID is $VID"
	./test_decoder.sh $VID
done
