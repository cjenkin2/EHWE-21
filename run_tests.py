#!/usr/bin/python

#TODO argument parsing
#TODO refactor execute_test_block!

import sys
import subprocess
import random

class Test:
        def __init__(self, command, helptxt):
                self.command = command
                self.helptxt = helptxt

flags = ['-s', '-p', 'r']
tests_lookup = {
        'network'    : Test('cd ./network_test; ./run_network_test.sh', ""),
        'vpu'        : Test('cd ./vpu_test; ./run_vpu_test.sh',""),
        'vpu_encoder': Test('cd ./vpu_test; ./run_encoder_test.sh',""),
        'gpu'        : Test('cd ./gpu_test; ./run_gpu_test.sh',""),
        'filesystem' : Test('cd ./memory_test; ./run_memory_test.sh',"")
}
tests = tests_lookup.keys() # ['network', 'vpu', 'gpu', 'memory']

def usage():
        print "usage:" , sys.argv[0] , """<-<spr> <test [ <args...> ]>* >*
    i.e. specify 0 or more times how (sequential, parallel, or random) 
    to run a given list of tests. """ , tests
        print ""
        print """    Each test can be optionally followed by command line arguments 
    surrounded by [  ] (whitespace is important!)"""
        print ""
	print "    e.g. '$ " , sys.argv[0] , """-p gpu [ 100 ] vpu -r network memory [ /dev/mmcblk0p2 ]' 
    would run the gpu and vpu tests in parallel (running the gpu tests for only 100 frames), 
    and then run the network and memory tests sequentially in random order
    (with read, write, and performance tests on /dev/mmcblk0p2)"""
	print ""
	print """    Finally, you can also use --help <test...> to get more information about a specific test
    (--help must be the first argument encountered. If it is, no tests will be run)"""

# print usage if run with no arguments
if len(sys.argv) == 1: # nothing to run
        usage()
        exit()

# test for "help" first
if sys.argv[1] == '--help':
        if len(sys.argv) == 2: # print usage if run with no tests
                usage()
        else:
                for test in sys.argv[2:]:
                        print test , ": " , tests_lookup[test].helptxt
        exit()

# because Python's append isn't sane
# edit: ok, because python's *lists* aren't sane.
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
                        subprocess.call(tests_lookup[test].command, shell=True)
        elif block[0] == '-r':
                tests = block[1:]
                random.shuffle(tests)
                for test in tests:
                        subprocess.call(tests_lookup[test].command, shell=True)
        elif block[0] == '-p':
                for test in block[1:]:
                        subprocess.call(tests_lookup[test].command + " &", shell=True)
        else:
                print "Debug message: a execution flag of '" , block[0] , ' here should be impossible'

# list of tests to exec following a single flag. way to exec is first arg
test_block = []
# all test blocks encountered in command line args
all_test_blocks = []

sys.argv.append('-s') # hackery to get last block

# Argument parsing (minus help) as a state table of a Finite State Automaton
#       | -word (flag)          | word (arg or test)    | () (argument_delimit)
#------------------------------------------------------------------------
# INIT: | start new test block  | Error                 | Error                 |
#       |new state: TESTS       |                       |                       |
#------------------------------------------------------------------------
# TESTS:| start new test block  | append to test block  | no action
#       |new state: TESTS       | new state: TESTS      | new state: ARGS
#------------------------------------------------------------------------
# ARGS: | append to prev test   | append to prev. test  | no action
#       | new state: ARGS       | new state: ARGS       | new state: TESTS
#------------------------------------------------------------------------

state="INIT"
for arg in sys.argv[1:]:
        if state=="INIT": # looking for a flag
                if not (arg in flags): # bad flag
                        print "Error:" , arg , "is not a valid flag!"
                        usage()
                        exit(1)
                else:
                        test_block.append(arg) # action
                        state="TESTS" # transition
        elif state=="TESTS":
                if arg in tests:
                        test_block.append(tests_lookup[arg].command)  # action
                        # state="TESTS"         # transition
                elif arg in flags:
                        append_list_sane(all_test_blocks, test_block) # one whole test block
                        test_block = [arg]      # action(s)
                        # state = "TESTS"       # transition
                elif arg == '[':
                        state = "ARGS"          # transition (no action)
                else:
                        print "Error:" , arg , "is not a valid test or flag"
        elif state=="ARGS":
                if arg == ']':
                        state="TESTS"           # transition (no action)
                else:
                        test_block[-1] = test_block[-1] + " " + arg

for block in all_test_blocks:
        print block

print sys.argv
"""                        
for arg in sys.argv[1:]:
        if test_block == []: # looking for a flag to run a fresh set of tests
                if not (arg in flags): # bad flag
                        print "Error:" , arg , "is not a valid flag!"
                        usage()
                        exit(1)
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
                        exit(1)
"""
#for block in all_test_blocks:
#        exec_test_block(block)
