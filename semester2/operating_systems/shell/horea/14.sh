# Write a bash script that receives a folder name as an argument. Find recursively in the folder the number of times each file name is repeated.

#!/bin/bash

if [ -z "$1" ]; then
	echo "Please provide one argument"
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "Argument must be a directory"
	exit 1
fi

find "$1" -type f | awk -F/ '{print $NF}' | sort | uniq -c
