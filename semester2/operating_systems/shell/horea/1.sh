# Write a bash script that counts all the c files from a given directory and all of its subdirectories.

#!/bin/bash

if [ ! $# -eq 1 ]; then
	echo "not enough arguments"
	exit 1
fi

if [ ! -d $1 ]; then
	echo "$1 is not a directory"
	exit 1
fi

find $1 -type f | grep -E -c "\.c$"

