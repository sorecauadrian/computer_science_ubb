# Find recursively in a given directory all the symbolic links, and report those that point to files/directories that no longer exist. Use operator -L to test if a path is a symbolic link, and operator -e to test if it exists (will return false if the target to which the link points does not exist)

# Suggested Commands
# find, if

#!/bin/bash

if [ $# -lt 1 ]; then
	echo "insufficient arguments"
	exit 1
fi
if [ ! -d "$1" ]; then
	echo "parameter is not a folder"
	exit 1
fi	

find $1 -type l | while read -r link; do
	if [ ! -e "$link" ]; then
		echo "broken link: $link"
	fi
done
