#!/bin/bash

STAGE=$1
SEARCH_PATTERN=$2

DOTDIR=$(pwd)/dots
GRAPHDIR=$(pwd)/graphs

DOTFILE=$(ls $DOTDIR/* | grep "$SEARCH_PATTERN" | grep "$STAGE")

if [ -z "$DOTFILE" ]
then
	echo "Warning: no $STAGE graph of gst pipeline available for video!"
else
	dot -Tpng -o"$GRAPHDIR/$(basename $DOTFILE).png" $DOTFILE
fi
