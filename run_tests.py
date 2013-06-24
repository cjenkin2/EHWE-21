#!/usr/bin/python

import sys
import subprocess
import random

flags = ['-s', '-p', 'r']
tests_lookup = {
        'network'    : 'cd ./network_test; ./run_network_test.sh',
        'vpu'        : 'cd ./vpu_test; ./run_vpu_test.sh',
        'vpu_encoder': 'cd ./vpu_test; ./run_encoder_test.sh',
        'gpu'        : 'cd ./gpu_test; ./run_gpu_test.sh',
        'filesystem' : 'cd ./memory_test; ./run_memory_test.sh'
}
tests = tests_lookup.keys() # ['network', 'vpu', 'gpu', 'memory']

def usage():
        print "usage:" , sys.argv[0] , """[-[spr] <tests...>]*
    i.e. specify 0 or more times how (sequential, parallel, or random) 
    to run a given list of tests """ , tests
        print ""
	print "    e.g. '$ " , sys.argv[0] , """-p gpu vpu -r network memory' 
    would run the gpu and vpu tests in parallel, 
    and then run the network and memory tests sequentially in random order"""

# print usage if run with no arguments
if len(sys.argv) == 1: # nothing to run
        usage()
        exit()

# because Python's append isn't sane
# append by value (shallow) rather than reference
def append_list_sane(xs, ys):
        copy = []
        for y in ys:
                copy.append(y)
        xs.append(copy)

# requires `block' conforms to usage
# takes the first argument (flag) and determines how to execute the remaining (tests)
def exec_test_block(block):
        if block[0] == '-s': # sequential
                for test in block[1:]:
                        subprocess.call(tests_lookup[test], shell=True)
        elif block[0] == '-r':
                tests = block[1:]
                random.shuffle(tests)
                for test in tests:
                        subprocess.call(tests_lookup[test], shell=True)
        else: # must be -p
                for test in block[1:]:
                        subprocess.call(tests_lookup[test] + " &", shell=True)

# list of tests to exec following a single flag. way to exec is first arg
test_block = []
# all test blocks encountered in command line args
all_test_blocks = []

sys.argv.append('-s') # hackery to get last block

for arg in sys.argv[1:]:
        if test_block == []: # looking for a flag to run a fresh set of tests
                if not (arg in flags): # bad flag
                        print "Error:" , arg , "is not a valid flag!"
                        usage()
                        exit()
                else:
                        test_block.append(arg)
        else: # in the process of building a set of commands
                if arg in tests:
                        test_block.append(arg)
                elif arg in flags:
                        append_list_sane(all_test_blocks, test_block) # got one fully formed test block
                        test_block = [arg]
                else:
                        print "Error:" , arg , "is not a valid test!"
                        usage()
                        exit()

for block in all_test_blocks:
        exec_test_block(block)
