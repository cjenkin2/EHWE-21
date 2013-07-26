#!/bin/bash

echo "/dev/$(echo $1 | cut -d':' -f1)"
