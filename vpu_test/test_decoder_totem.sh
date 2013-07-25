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
./dot_cleanup.sh "$VID_FILE_BASENAME.$DATE" "totem"

# make graph of pre-rolled
echo $(./mk_pipeline_graph.sh "prerolled" "$DATE") | tee -a $LOGFILE | cat
