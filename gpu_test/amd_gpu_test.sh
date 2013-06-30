#!/bin/bash

if [[ $# -ne 2 ]]
then
	echo "usage: $0 <time> <num_instances>"
	echo "$0 runs <num_instances> of the available AMD GPU tests for <time> seconds"
	exit 65 # bad arguments
fi

TIME=$1
NUM_INSTANCES=$2

# shaded out programs exit on <Enter> pressed, difficult to script

# Just launches demos all at once
#tiger &
#tiger_ri &
#es11ex & 

for i in $(seq 1 $NUM_INSTANCES)
do
	torusknot 1000000000000000 &
	simple_draw &
done

sleep $TIME

killall torusknot
killall simple_draw
