#! /bin/bash

S=$1
shift

for arg in $@; do
	if [-f $arg]; then
		count = $(grep -c $S $arg)
		if [$count -le 3]; then
			echo "the sequence $S was found on at most 3 distinct lines in $arg"
		fi
	elif [-d $arg]; then
		count = $(ls $arg | grep -c $S)
		if [$count -ge 3]; then
			echo "$arg contains at least 3 items whose name contains the sequence"
		fi
	else
		echo "$arg is not a regular file or directory"
	fi
done
