#!/bin/bash

if [ $# -ne 2 ]
then
	echo "usage: $0 <name> <search_pattern>"
fi

NAME=$1
SEARCH_PATTERN=$2

DOTDIR=$(pwd)/dots

#rename generated dot files
for DOTFILE in $(ls $GST_DEBUG_DUMP_DOT_DIR/* | grep "$SEARCH_PATTERN")
do
        mv $DOTFILE "$DOTDIR/encode.$NAME.$(basename $DOTFILE)"
done
