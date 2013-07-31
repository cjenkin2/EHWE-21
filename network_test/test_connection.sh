#!/bin/bash

if [ $# -ne 2 ] #Expects one file - input video file 
then
        echo "Usage: $0 <time> <wpa_configuration_file>"
	echo "Note: use \`wpa_passphrase [ssid] [passphrase] > wpa.conf' to generate"
        exit 65 # bad arguments
fi

TIME=$1
WPA_CONF=$2

#Start the network from the command line
sudo service network-manager stop 
sudo killall -9 wpa_supplicant
timeout 1h sudo wpa_supplicant -B -Dwext -iwlan0 -c $WPA_CONF -d 
timeout 1h sudo dhclient wlan0

#TODO query for status. Program marches on to tests whether or not
# a network connection is established

#Run network test commands
./download_ubuntu.sh $TIME &

HOSTS="genesi-tech.com google.com wikipedia.org"

for HOST in $HOSTS
do
	./flood-ping.sh $HOST $TIME &
done

sleep $TIME
