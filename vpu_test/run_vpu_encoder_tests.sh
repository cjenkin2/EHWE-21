#!/bin/bash

#no YUV files, skip empty lines out output
VID_DIR=$(pwd)/clips
YUV_DIR=$(pwd)/yuv
OUT_DIR=$(pwd)/encoder/vids

VIDEOS=$(ls $VID_DIR/* | grep -v yuv | grep -v ^$)

for VIDEO in $VIDEOS
do
	VID_BASENAME=$(basename $VIDEO)
	if [ -e $YUV_DIR/$VID_BASENAME.yuv ] 
	then
		:
	else
		echo "Creating YUV file of $VIDEO"
		./mkyuv.sh $VIDEO $YUV_DIR/$VID_BASENAME.yuv
	fi
done

# should be just one for loop but extracting this information from
# gstreamer can be difficult

for YUV_FILE in $(ls $YUV_DIR/* | grep "big_buck_bunny_720x576")
do
	echo "Video is $YUV_FILE"
	./encode_yuv.sh $YUV_FILE $OUT_DIR/$(basename $YUV_FILE).h264 720 576 'video/x-h264'
	./encode_yuv.sh $YUV_FILE $OUT_DIR/$(basename $YUV_FILE).mpeg 720 576 'video/mpeg' 'codec-type=0'
done

#for VIDEO in $VIDEOS
#do
#	echo "Encoding $VIDEO to h264"
#	./test_encoder.sh $VIDEO 'video/x-h264'
#done

#for VIDEO in $VIDEOS
#do
#	echo "Encoding $VIDEO to mpeg"
#	./test_encoder.sh $VIDEO 'video/mpeg' 'codec-type=0'
#done
