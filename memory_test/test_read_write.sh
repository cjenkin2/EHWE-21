#!/bin/bash

if [[ $# -ne 1 ]]
then
	echo "usage: $0 outfile"
	echo ""
	echo "$0 writes 2200 copies of lorem ipsum to the specified file location, "
	echo "then checks to see that the resulting file matches the pre-generated md5sum"
	exit 65 # bad params
fi

OUTFILE=$1

zcat loremipsum_2200.txt.gz > $OUTFILE

echo $(./md5sum_compare.sh loremipsum_2200.txt.md5sum $OUTFILE)
