# Find recursively in a directory all ".c" files having more than 500 lines. Stop after finding 2 such files.

# Suggested Commands
# find, wc, expr, while, break

# Expected Result
# dir/11.c
# dir/d/a/13.c

#!/bin/bash

i=0
find $1 -name "*.c" | while read file; do
	count_lines=`cat $file|wc -l`
	if [ $count_lines -gt 500 ]; then
		echo $file
		i=`expr $i + 1`
	fi
	if [ $i -eq 2 ]; then
		break
	fi
done
