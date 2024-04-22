# Find recursively in a directory, all the files with the extension ".log" and sort their lines (replace the original file with the sorted content).

# Suggested Commands
# find, sort, mv, rm

# Expected Result
# The *.log files in test directory "dir" should be all sorted.

#!/bin/bash

aux="auxiliar"

find $1 -type f -name "*.log" | while read file; do
	cat $file | sort > $aux
	mv $aux $file
done
	
