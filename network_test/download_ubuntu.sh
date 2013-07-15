#!/bin/bash

wget -a wget-ubuntu.log -b http://www.ubuntu.com/start-download?distro=desktop&bits=32&release=lts &

sleep 1200

killall wget
rm start-download*
