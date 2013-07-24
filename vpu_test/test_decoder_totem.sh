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
VID=$1
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

echo "Using Totem to generate pipeline for $VID" | tee -a $LOGFILE | cat

TOTEM_OUTPUT=$(timeout 40 totem --no-existing-session $VID 2>&1)

echo "$TOTEM_OUTPUT" >> $LOGFILE

#rename generated .dot files
for DOTFILE in $(ls $GST_DEBUG_DUMP_DOT_DIR/* | grep "totem")
do
	mv $DOTFILE $DOTDIR/decode.$VID_FILE_BASENAME.$DATE.$(basename $DOTFILE)
done

# make graph of pre-rolled
PREROLLED_DOT=$(ls $DOTDIR/* | grep "$DATE" | grep "prerolled")

if [ -z "$PREROLLED_DOT" ]
then
	echo "Warning: no graph of Totem prerolled pipeline for $VID" | tee -a $LOGFILE | cat
else
	dot -Tpng -o"$GRAPHDIR/$(basename $PREROLLED_DOT).png" $PREROLLED_DOT
fi
