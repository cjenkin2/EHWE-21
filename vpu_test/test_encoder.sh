#!/bin/bash

#requires gstreamer0.10-tools

# expects two argumets 
#    the name of the file and the output cap of the mfw_vpuencoder
if  [[ ($# -ne 2) && ($# -ne 3) ]]
then
	echo "usage: $0 <intput-vid-file> <mfw_vpuencoder_cap> [mfw_vpuencoder_params]"
	echo "e.g. : $0 "'$BIG_BUCK_BUNNY '"'video/x-h264'"
	echo "     : $0 "'$SINTEL'"video/mpeg codec-type=0"
	exit 65 # bad arguments
fi

#argument names
VIDEO=$1
CAP=$2

# for readability only
if [[ -z $3 ]]
then
	PARAMS=""
else
	PARAMS=$3
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

#local variables
LOGFILE="encode.log"
OUTDIR="$(pwd)/encoder/vids"
DOTDIR="$(pwd)/dots"
GRAPHDIR="$(pwd)/graphs"
#generate appropriate extension from cap
EXT=$(echo $CAP | cut -d"-" -f2)
VID_FILE_BASENAME=$(basename $VIDEO)
OUTPUT_FILE="$OUTDIR/$(basename $VIDEO).$EXT" # warning does not work for mpeg
MD5="$OUTPUT_FILE.md5sum"

#code
set_date
echo "============================" >> $LOGFILE
echo "$DATE"                        >> $LOGFILE
echo "encoding: $VIDEO"             >> $LOGFILE
echo "format  : $CAP"               >> $LOGFILE
echo "params  : $PARAMS"            >> $LOGFILE
echo "----------------------------" >> $LOGFILE

GST_LAUNCH_OUTPUT=$(gst-launch filesrc location=$VIDEO ! decodebin2 ! queue ! mfw_vpuencoder $PARAMS ! $CAP ! filesink location=$OUTPUT_FILE 2>&1)
md5sum $OUTPUT_FILE > $MD5

echo "$GST_LAUNCH_OUTPUT" >> $LOGFILE

#rename generated dot files
for DOTFILE in $(ls $GST_DEBUG_DUMP_DOT_DIR/* | grep "gst-launch")
do
        mv $DOTFILE "$DOTDIR/encode.$VID_FILE_BASENAME.$DATE.$(basename $DOTFILE)"
done

#make graph of PAUSED_READY
READY_PAUSED_DOT=$(ls $DOTDIR/* | grep "$DATE" | grep "READY_PAUSED")
dot -Tpng -o"$GRAPHDIR/$(basename $READY_PAUSED_DOT).png" $READY_PAUSED_DOT
