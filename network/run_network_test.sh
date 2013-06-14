#!/bin/bash

if [ $# -ne 1 ] #Expects one file - input video file 
then
        echo "Usage: $0 <wpa_configuration_file>"
	echo "Note: use \`wpa_passphrase [ssid] [passphrase] > wpa.conf' to generate"
        exit 65 # bad arguments
fi

#Start the network from the command line
sudo service network-manager stop 
sudo killall -9 wpa_supplicant
sudo wpa_supplicant -B -Dwext -iwlan0 -c $1 -d 
sudo dhclient wlan0

#TODO query for status. Program marches on to tests whether or not
# a network connection is established

#Run network test commands
wget -b http://www.ubuntu.com/start-download?distro=desktop&bits=32&release=lts &

#ping test
#attribution: www.cyberciti.biz/tips/simple-linux-and-unix-system-monitoring-with-ping-command-and-scripts.html
HOSTS="this_is_not_a_host genesi-tech.com google.com apple.com"
DEADLINE=90

for myHost in $HOSTS
do
	count=$(sudo ping -i 0 -w $DEADLINE $myHost | grep 'received' | awk -F',' '{ print $2v}' | awk '{ print $1 }')
	echo "Count is $count"
	if [ "$count" -eq 0 ]; then
		echo "Could not reach host $myHost"
	fi
done
#ping -c 100 google.com &
#sudo ping -f genesi-tech.com &
