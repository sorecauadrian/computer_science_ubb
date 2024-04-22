# Write a bash script that receives any number of command line arguments and prints on the screen, for each argument, if it is a file, a directory, a number or something else.

#!/bin/bash

while [ ! $# -eq 0 ]; do
	arg=$1
	if [ -f $arg ]; then
		echo "$arg is a regular file"
	elif [ -d $arg ]; then
		echo "$arg is a directory"
	elif echo $arg | grep -E -q "^[0-9]+$"; then
		echo "$arg is an integer number"
	else
		echo "$arg is something else"
	fi
	shift
done
