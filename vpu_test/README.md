VPU Tests: A collection of scripts and video scenes for testing VPU encoding/decoding on iMX.5X
===============================================================================================

Prerequisists
-------------
In order to use these tests, the gstreamer tools and graphviz packages must first be installed.
This can be done by running the command `installs.sh' in this directory's parent, or by typing

	sudo apt-get install gstreamer0.10-tools graphviz

Testing gstreamer pipelines with 'test\_decoder.sh'
---------------------------------------------------
This script takes as its only argument a video file to decode (it only works on absolute paths for the time being).
For example, 

	./test_decoder $VIDS/big_buck_bunny.avi

where $VIDS it the full path the the folder containing the file "big_buck_bunny.avi."

The script plays the specified video with gst-launch, redirecting gstreamer's 'dot' (a common directed graph language) output to 'temp'.
It then helpfully renames each generated 'dot' to include original video file name and date created, then moves these to 'output'.
Additionally, this script then runs the program 'dot' (from the graphviz package) to generate a graphic representation of the pipeline gstreamer generates when gst-launch transitions from READY to PAUSED.
This stage was chosen because it seemed to provide the most information about the process in general.

All gst-launch output is saved to 'decode.log'

Testing gstreamer pipelines with 'generate\_pipeline.sh'
-------------------------------------------------------
Run the following command to make sure you can use this script

	sudo apt-get install gstreamer0.10-tools graphviz

To use this script, run it in the vpu_test directory with a video filename to test, e.g.

	./generate_pipeline.sh $(pwd)/clips/big_buck_bunny_720p_surround.clip.avi

(Unfortunately, relative paths to files are not currently supported, so specify a full path for the time being)

This script runs gst-launch-0.10 on the file given, using the playbin2 option.
Before this, it sets an environment variable GST_DEBUG_DUMP_DOT_DIR to the pipeline_output directory. 
Setting this variable to $PATH tells gstreamer to dump all of its '.dot' files (standard syntax for directed graphs) in $PATH.

After gst-launch finishes, the script runs the program dot on the .dot file representing media player state transition from READY to PAUSED (this one seems to have the most information available).
dot generates a .png file representing the pipeline gstreamer automatically created.

Finally, as a bit of cleanup, the script runs through the .dot files recently generated and helpfully renames them, based on the file used and the date the script was run.

Graphviz: Genereal Usage for gstreamer
======================================

dot
---

In order to use dot to view gstreamer pipelines, first tell gstreamer to place its .dot output files in $PATH with

	export GST_DEBUG_DUMP_DOT_DIR=$PATH

Then, run a gstreamer pipeline using gst-launch-0.10
This will produce several .dot files in $PATH
Select the one you wish to view ($DOTFILE) and create an image for it with

	dot -Tpng 		-o"$OUTFILE_NAME.png" 	$DOTFILE
	#   output png		name of output file	name of input file

Attribution
===========
http://lists.freedesktop.org/archives/gstreamer-devel/2011-September/033052.html
