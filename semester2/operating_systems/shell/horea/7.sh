# Write a bash script that calculates the sum of the sizes (in bytes) of all regular files in a folder given as a parameter.(use test to check if the folder exists and if a given file is a regular file)

#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Please provide one directory"
	exit 1
fi

if [ ! -d $1 ]; then
	echo "The argument given is not a directory"
	exit 1
fi

sum=0

for f in $(ls $1); do
	if [ -f "$1/$f" ]; then
		size=$(du -b "$1/$f" | awk '{print $1}')
		echo "File: $f - Size: $size"
		sum=$((sum+size))
	fi
done

echo "Total size of regular files from folder $1 is $sum"
