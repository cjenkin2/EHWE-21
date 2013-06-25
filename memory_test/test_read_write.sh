#!/bin/bash

if [[ $# -ne 1 ]]
then
	echo "usage: $0 outfile"
	echo "$0 writes 2200 copies of lorem ipsum to the specified file location, "
	echo "then checks to see that the resulting file matches the pre-generated md5sum"
fi

OUTFILE=$1

zcat loremipsum_2200.txt.gz > $OUTFILE
zcat loremipsum_2200.txt.gz > loremipsum_2200.txt
md5sum -c $OUTFILE

#cleanup
rm loremipsum_2200.txt
