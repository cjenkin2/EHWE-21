#!/bin/bash

#requires gstreamer0.10-tools graphviz

OUTDIR="$(pwd)/output"
VIDEO_DIR="$(pwd)/clips"
VIDEOS=$(ls "$VIDEO_DIR/"*)
DECODELOG="decode.log"

export GST_DEBUG_DUMP_DOT_DIR=$OUTDIR
export DATE=""

function set_date()
{
	DATE="$(date)"
	DATE="${DATE// /_}"
	DATE="${DATE//:/-}"
}

export -f set_date

echo "=================================" >> $DECODELOG

#test decoder with gst-launch
for VIDEO in $(echo "$VIDEOS" | grep "big_buck_bunny_720x526_surround.clip2.avi")
do
	set_date
	echo "---------------------------------" >> $DECODELOG
	echo "$DATE"                             >> $DECODELOG
	echo "Decoding: $VIDEO"                  >> $DECODELOG

	./test_decoder.sh $VIDEO

	for DOTFILE in $(ls $OUTDIR/* | grep "gst-launch")
	do
		DOTFILE_MV="$OUTDIR/$(date).$(basename $VIDEO)."$(echo $(basename $DOTFILE) | rev | cut -d"." -f-2 | rev)
		echo $DOTFILE_MV
	done
done

#generate graphs and rename dot outputs
#for DOTFILE in $(ls $OUTDIR/* | grep "gst-launch")
#do
#	DOTFILE_MV="$OUTDIR/$DATE.$(basename )"
#        mv $DOTFILE "$OUTDIR/$DATE.$VID_FILE_BASENAME."$(echo $(basename $DOTFILE) | rev | cut -d"." -f-2 | rev)
#done









#gst-launch-0.10 playbin2 uri=file://$1

#DATESTR=$(date)
#DATESTR="${DATESTR// /_}"
#dot -Tpng -o"$OUTDIR/$VID_FILE_BASENAME"'.READY_PAUSED'".$DATESTR"'.png' $(ls "$OUTDIR/"* | grep gst-launch.READY_PAUSED)

#for f in $(ls $OUTDIR/* | grep "gst-launch")
#do
#	mv $f "$OUTDIR/$DATESTR.$VID_FILE_BASENAME."$(echo $(basename $f) | rev | cut -d"." -f-2 | rev)
#done
