#!/bin/bash

VIDEOS=$(ls $(pwd)/clips/*)

for VIDEO in $VIDEOS
do
	echo "Encoding $VIDEO to h264"
	./test_encoder.sh $VIDEO 'video/x-h264'
done

for VIDEO in $VIDEOS
do
	echo "Encoding $VIDEO to mpeg"
	./test_encoder.sh $VIDEO 'video/mpeg' 'codec-type=0'
done
