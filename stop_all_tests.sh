#!/bin/bash

sudo killall run_tests.py

#gpu
sudo killall run_gpu_test.sh
sudo killall amd_gpu_test.sh
sudo killall torusknot simple_draw

#vpu
sudo killall run_vpu_test.sh
sudo killall run_vpu_decoder_tests.sh run_vpu_encoder_tests.sh
sudo killall test_decoder.sh test_encoder.sh
sudo killall gst-launch-0.10 dot

#memory_device
sudo killall run_memory_device_test.sh
sudo killall filesystem_test.sh benchmark_test.sh badblocks_test.sh md5sum_compare.sh
sudo killall badblocks dd hdparm gzip md5sum

#network
sudo killall run_network_test.sh
./network_test/interrupt_network.sh
