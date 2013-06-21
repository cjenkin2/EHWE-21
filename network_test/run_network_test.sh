#!/bin/bash

if [ -e ./wpa.conf ]
then
	./test_connection.sh ./wpa.conf
else
	./test_connection.sh
fi
