# Write a bash script that sorts the file given as command line arguments in ascending order according to their file size in bytes.

#!/bin/bash

for f in $@; do
	if test -f $f; then
		du -b $f
	fi
done | sort -n
