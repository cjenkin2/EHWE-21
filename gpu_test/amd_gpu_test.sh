#!/bin/bash

if [[ $# -ne 2 ]]
then
	echo "usage: $0 <frame_num> <num_instances>"
	echo "$0 runs <num_instances> of the available AMD GPU tests concurrently each for <frame_num> frames"
	exit 65 # bad arguments
fi

FRAMES=$1
NUM_INSTANCES=$2

# shaded out programs exit on <Enter> pressed, difficult to script

# Just launches demos all at once
#tiger &
#tiger_ri &
#es11ex & 

for i in $(seq 1 $NUM_INSTANCES)
do
	torusknot $FRAMES &
	simple_draw -f $FRAMES &
done
