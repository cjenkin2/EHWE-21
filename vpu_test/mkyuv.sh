#!/bin/bash

if [ $# -ne 2 ] # expects input, demux, output
then
	echo "usage: $0 <input_file> <output_vid>"
	exit 65 # bad parameters
fi

VIDEO=$1
OUTPUT=$2

gst-launch filesrc location=$VIDEO ! decodebin2 ! \
"video/x-raw-yuv,format=(fourcc)I420" ! filesink location=$OUTPUT


