EHWE-21
=======

Stress testing i.MX53 Boards
----------------------------

Each of the following stress tests can be run separately or in any combination using the master script 'run_tests.py'.
Each section below gives a brief overview of the behavior of the test scripts, the arguments they take, and the default values used by the master script.

vpu_test
========

The scripts 'test_decoder.sh' and 'test_encoder.sh' both us gst-launch to construct gstreamer pipelines for decoding and encoding videos, respectively.
In addition, gstreamers debug 'dot' data which details the created pipelines is output to the 'vpu_test/dots' directory.
From these dots, both scripts also generate a graph of the 'PAUSED_PLAYING' pipeline using the program 'dot' from the graphviz library.

test_decoder.sh
---------------

usage: test_decoder.sh <input_vid_file>

This script tests the decoder by creating a gstreamer pipeline with playbin2 to play a video.
For the time being it requires its argument to be an absolute path to the video to decode.

WARNING: The default rendering video sink (eglsink) is still rather buggy.
Consequently, this test will probably not function very well, and may even crash the system. Caution is advised.

test_encoder.sh
---------------

usage: ./test_encoder.sh <intput-vid-file> <mfw_vpuencoder_cap> [mfw_vpuencoder_params]
e.g. : ./test_encoder.sh $BIG_BUCK_BUNNY 'video/x-h264'
     : ./test_encoder.sh $SINTEL 'video/mpeg' codec-type=0

This script tests the encoder by creating a gstreamer pipeline to convert the input video to the user-specified encoding.
If the video encoding requires specific parameter values for the mfw_vpuencoder, these can be given as an optional argument.
After the video files are encoded, the script generates md5sum hashes of the results and stores them in $REPO/vpu_test/encoder/vids.
These hash values can be compared to the hashes in $REPO/vpu_test/encoder/i.MX51_Smartbook with the same name to verify that the encoder produced correct results.

gpu_test
--------

network_test
------------

memory_test
-----------



