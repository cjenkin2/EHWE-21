#!/bin/bash

if [[ $# -ne 2 ]]
then
	echo "usage: $0 <oldhash> <newfile>"
	exit 65 # bad arguments
fi

# params
OLDHASHFILE=$1
NEWFILE=$2

# variables
OLDHASH=$(cut -c1-32 $OLDHASHFILE)

# code
echo $(echo "$OLDHASH  $NEWFILE" | md5sum -c)

