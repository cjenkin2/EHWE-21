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

This test tests the decoder by creating a gstreamer pipeline with playbin2 to play a video.

WARNING: The default rendering video sink (eglsink) is still rather buggy.
Consequently, this test will probably not function very well, and may even crash the system. Caution is advised.




gpu_test
--------

network_test
------------

memory_test
-----------


