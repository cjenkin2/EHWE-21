#!/bin/bash

VIDS=$(ls ./clips/*)

for VID in $VIDS
do
	echo "VID is $VID"
	./test_decoder.sh $VID
done
