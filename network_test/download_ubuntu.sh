#!/bin/bash

if [ $# -ne 1 ]
then
	echo "usage: $0 TIME"
	exit 65 # bad args
fi

WGET_TIME=$1

wget -a wget-ubuntu.log -b http://www.ubuntu.com/start-download?distro=desktop&bits=32&release=lts &

sleep $WGET_TIME

killall wget
rm start-download*
