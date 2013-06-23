#!/bin/bash

if [[ $# -ne 1 ]]
then
	echo "usage: $0 <time>"
	echo "$0 runs the available AMD GPU tests for <time> seconds"
	exit 65 # bad arguments
fi

# shaded out programs exit on <Enter> pressed, difficult to script

# Just launches demos all at once
#tiger &
#tiger_ri &
torusknot 1000000000000000 &
simple_draw &
#es11ex & 

sleep $1

killall torusknot
killall simple_draw
