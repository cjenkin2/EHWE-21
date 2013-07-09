#!/bin/bash

VIDEOS=$(ls $(pwd)/clips/*)

for VIDEO in $VIDEOS
do
	./test_encoder.sh $VIDEO 'video/x-h264'
done

for VIDEO in $VIDEOS
do
	./test_encoder.sh $VIDEO 'video/mpeg' 'codec-type=0'
done
