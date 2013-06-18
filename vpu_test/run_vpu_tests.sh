#!/bin/bash

#requires gstreamer0.10-tools graphviz

VIDEO_DIR="$(pwd)/clips"
VIDEOS=$(ls "$VIDEO_DIR/"*)

#test decoder with gst-launch
for VIDEO in $(echo "$VIDEOS")
do
	./test_decoder.sh $VIDEO
done
