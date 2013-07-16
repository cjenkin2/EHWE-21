#!/bin/bash

#requires gstreamer0.10-tools

#Parameter checking
if [ $# -ne 1 ] #Expects one file - input video file 
then
	echo "Usage: $0 <input-vid-file>"
	exit 65 # bad arguments
fi

#helper functions
function set_date()
{
        DATE="$(date)"
        DATE="${DATE// /_}"
        DATE="${DATE//:/-}"
}

#export variables
export GST_DEBUG_DUMP_DOT_DIR="$(pwd)/temp"

#local variable
VID_FILE_BASENAME=$(basename $1)
OUTDIR="$(pwd)/output"
DOTDIR="$(pwd)/dots"
GRAPHDIR="$(pwd)/graphs"
LOGFILE="decode.log"

#code
set_date
echo "============================" >> $LOGFILE
echo "$DATE"                        >> $LOGFILE
echo "Decoding: $VID_FILE_BASENAME" >> $LOGFILE
echo "----------------------------" >> $LOGFILE

echo "using pipeline: gst-launch-0.10 playbin2 uri=file://$1 video-sink='mfw_xvimagesink'" | tee -a $LOGFILE | cat

GST_LAUNCH_OUTPUT=$(timeout 240 gst-launch-0.10 playbin2 uri=file://"$1" video-sink="mfw_xvimagesink" 2>&1)

echo "$GST_LAUNCH_OUTPUT" >> $LOGFILE

#rename generated .dot files
for DOTFILE in $(ls $GST_DEBUG_DUMP_DOT_DIR/* | grep "gst-launch")
do
	mv $DOTFILE $DOTDIR/decode.$VID_FILE_BASENAME.$DATE.$(basename $DOTFILE)
done

#make graph of PAUSED_READY
READY_PAUSED_DOT=$(ls $DOTDIR/* | grep "$DATE" | grep "READY_PAUSED")

if [ -z "$READY_PAUSED_DOT" ]
then
	echo "Warning: no graph of gstreamer READY_PAUSED pipeline for $VIDEO" | tee -a $LOGFILE | cat
else
	dot -Tpng -o"$GRAPHDIR/$(basename $READY_PAUSED_DOT).png" $READY_PAUSED_DOT
fi
