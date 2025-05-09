# Display a report showing the full name of all the users currently connected, and the number of processes belonging to each of them.

# Suggested Commands
# who, ps, finger, grep, while, wc

# Expected Result
# bradu 2
# horea 2
# rares 3

#!/bin/bash
cat who.fake | awk '{print $1}' | while read user
do
	counter=`cat ps.fake | grep -E "^$user" | wc -l`
	echo "$user $counter"
done
