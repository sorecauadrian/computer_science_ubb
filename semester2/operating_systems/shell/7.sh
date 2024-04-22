# Consider a file containing a username on each line. Generate a comma-separated string with email addresses of the users that exist. The email address will be obtained by appending "@scs.ubbcluj.ro" at the end of each username. Make sure the generated string does NOT end in a comma.

# Suggested Commands:
# for, finger, grep, sed

# Expected Result
# Input file

# a
# b
# c

# should result in output:
# a@scs.ubbcluj.ro,b@scs.ubbcluj.ro,c@scs.ubbcluj.ro

#!/bin/bash

if [ ! $# -eq 1 ]; then
	echo "provide the input file name"
	exit 1
fi

if [ ! -f $1 ]; then
	echo "$1 is not a file"
	exit 1
fi

result=""

while IFS= read -r username; do
	result="$result$username@scs.ubbcluj.ro,"
done < $1

result=$(echo "$result" | sed 's/,$//')

echo "$result"
