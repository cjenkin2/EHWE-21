#!/bin/bash

if [ $# -eq 0 ]
then
	./amd_gpu_test.sh 1000 4
elif [ $# -eq 2 ]
then
	FRAMES=$1
	INSTANCES=$2
	./amd_gpu_test.sh $FRAMES $INSTANCES
else 
	echo "usage: $0 [ <frames> <instances> ]"
	echo "This function either supplies default values for these two parameters (1000 and 4, respectively)"
	echo "or takes them from command line arguments."
fi
