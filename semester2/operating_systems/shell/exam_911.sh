#! /bin/bash

for arg in $@; do
	if [-d $arg]; then
		echo "Largest files in directory $arg:"
		find $arg -type f | sort -rn | head -n 3
	elif [-f $arg]; then
		if [-w $arg]; then
			writable_files = $((writable_files + 1))
		fi
	fi
done
