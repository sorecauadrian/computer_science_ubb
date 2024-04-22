# Find recursively in a directory, all the files that have write permissions for everyone. Display their names, and the permissions before and after removing the write permission for everybody. You will need to use chmod's symbolic permissions mode, instead of the octal mode we have used in class. The the chmod manual for details.

# Suggested commands:
# find, chmod, ls

# Expected output:
# -rwxrwxrwx dir/d/c/b/15.c
# -rwxrwxr-x dir/d/c/b/15.c
# -rwxr---w- dir/d/b/6.txt
# -rwxr----- dir/d/b/6.txt
# -rwx-w-rw- dir/c/b/9.sh
# -rwx-w-r-- dir/c/b/9.sh

#!/bin/bash

if [ ! $# -eq 1 ]; then
	echo "provide the folder name"
	exit 1
fi

if [ ! -d "$1" ]; then
	echo "error: '$1' is not a directory"
	exit 1
fi

find "$1" -type f | while read -r file; do
	echo "before modification: $(ls -l "$file" | awk '{print $1 $9}')"
	chmod -c a-w "$file"
	echo "after modification: $(ls -l "$file" | awk '{print $1 $9}')"
done

# not really the right code, but almost there ;)
