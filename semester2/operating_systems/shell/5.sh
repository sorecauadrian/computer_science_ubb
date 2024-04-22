# Write a script that receives dangerous program names as command line arguments. The script will monitor all the processes in the system, and whenever a program known to be dangerous is run, the script will kill it and display a message.

# Suggested commands:
# while, ps, sleep, grep, kill, true

#!/bin/bash

if [ $# -lt 1 ]; then
	echo "insufficient arguments"
	exit 1
fi

while true; do
	for program_name in "$@"; do
		numberOfAppearences=$(grep -c "$program_name" ps.fake)
		if [ "$numberOfAppearences" -gt 0 ]; then
			pkill "$program_name"
			echo "dangerous program '$program_name' has been killed"
		fi
	done
	sleep 1
done


# examples of how you could run it:
# sh 5.sh cat
# sh 5.sh ps
