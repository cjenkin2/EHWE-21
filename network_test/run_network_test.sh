#!/bin/bash

if [ $# -lt 1 ]
then
	if [ -e "wpa.conf" ]
	then
		./test_connection.sh wpa.conf
	else
		echo "usage: $0 [ wpa_conf_file | ssid [ passphrase ] ]"
		echo "When run without arguments tries to read network configuration from ./wpa.conf"
	fi
elif [ -e $1 ] # assumes this is the proper wpa.conf
then
	./test_connection.sh $1
else # assumes this is the name of the network connection
	wpa_passphrase $1 $2 > wpa.tmp.conf
	./test_connection.sh wpa.tmp.conf
	rm wpa.tmp.conf
fi
