#!/bin/bash

#requires gstreamer0.10-tools

#Parameter checking
if [ $# -ne 1 ] #Expects one file - input video file 
then
	echo "Usage: $0 <input-vid-file>"
	exit 65 # bad arguments
fi

#local variable
VID_FILE_BASENAME=$(basename $1)
LOGFILE="decode.log"
DATE="$(date)"
DATE="${DATE// /_}"
DATE="${DATE//:/-}"

#code
echo "----------------------------" >> $LOGFILE
echo "$DATE"                        >> $LOGFILE
echo "Decoding: $VID_FILE_BASENAME" >> $LOGFILE

GST_LAUNCH_OUTPUT=$(gst-launch-0.10 playbin2 uri=file://"$1")

echo "$GST_LAUNCH_OUTPUT" >> $LOGFILE
echo "----------------------------" >> $LOGFILE
