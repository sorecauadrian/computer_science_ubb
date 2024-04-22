#  Write a bash script that counts all the lines of code in the C files from the directory given as command-line argument, excluding lines that are empty or contain only spaces.

#!/bin/bash

if [ -z "$1" ]; then
	echo "no parameters given"
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "parameter is not a folder"
	exit 1
fi

total=0

for f in $(ls "$1" | grep -E "\.c$"); do
	if test -f "$1/$f"; then
		nr_lines=$(grep -E -c -v "^[ \t]*$" "$1/$f")
		echo "$f: $nr_lines"
		total=$((total+nr_lines))
	fi
done

echo "Total lines: $total"
