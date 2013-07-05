#!/bin/bash

VIDS=$(ls ./clips/*)

for VID in "$VIDS"
do
	./test_decoder.sh $VID
done
