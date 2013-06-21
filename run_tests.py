#!/usr/bin/python

import sys

def usage():
	print "usage:" , sys.argv[0] , """[-[spr] <tests...>]*
    i.e. specify 0 or more times how (sequential, parallel, and random) 
    to run a given list of tests (gpu, vpu, network, filesystem)
"""
	print "    e.g. '$ " , sys.argv[0] , """-p gpu vpu -r network filesystem' 
    would run the gpu and vpu tests in parallel, 
    and then run the network and filesystem tests sequentially in random order"""

print sys.argv
usage()

#from optparse import OptionParser

#parser = OptionParser()
#parser.add_option("-s", "--sequential", dest="filename", 
#	help="write report to FILE", metavar="FILE")

#(options, args) = parser.parse_args()

