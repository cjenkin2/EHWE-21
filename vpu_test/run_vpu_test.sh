#!/bin/bash

#requires gstreamer0.10-tools graphviz

VIDEO_DIR="$(pwd)/clips"
VIDEOS=$(ls "$VIDEO_DIR/"*)

FORMATS='video/x-h264 video/x-h263'

#test decoder and encoder with gst-launch
#for VIDEO in $(echo "$VIDEOS")
#do
#	./test_decoder.sh $VIDEO
#done

# test encoder with gst-launch
for VIDEO in $(echo "$VIDEOS")
do
	for FORMAT in $FORMATS
	do
		./test_encoder.sh $VIDEO $FORMAT
	done
done
