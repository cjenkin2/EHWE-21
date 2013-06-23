#!/bin/bash

## acknowledgements
## www.linuxjournal.com/content/using-named-pipes-fifos-bash

export pipe=/tmp/gpu_test_pipe

trap "rm -f $pipe" EXIT

if [[ -p $pipe ]]; then # wipe it if it wasn't already
	rm -f $pipe
fi

mkfifo $pipe

(while true; do echo "hhhhhhhhhh" > $pipe;done &)

tiger < $pipe
