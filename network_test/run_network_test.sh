#!/bin/bash

if [ $# -lt 1 ]
then
	WGET_TIME=600
else
	WGET_TIME=$1
fi

if [ $# -lt 2 ]
then
	if [ -e "wpa.conf" ]
	then
		./test_connection.sh $WGET_TIME wpa.conf
	else
		echo "usage: $0 [time] [ wpa_conf_file | ssid [ passphrase ] ]"
		echo "When run without arguments tries to read network configuration from ./wpa.conf, uses time of 10 minutes"
	fi
elif [ -e $2 ] # assumes this is a proper wpa.conf
then
	./test_connection.sh $WGET_TIME $2
else # assumes $2 is the name of the network connection
	wpa_passphrase $2 $3 > wpa.tmp.conf
	./test_connection.sh $WGET_TIME wpa.tmp.conf
	rm wpa.tmp.conf
fi
