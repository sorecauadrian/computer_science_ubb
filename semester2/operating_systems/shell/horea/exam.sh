# EN:
# Write a bash script that takes any number of arguments from the command line.
# For each argument:
#  - if the argument is a directory, list all filenames recursively from that directory that contain at least 5 lines of text
#  - if the argument is a regular file whose name ends in ".sh", print the first 5 lines from the file

# RO:
# Scrieti un script bash care primeste oricate argumente la linia de comanda.
# Pentru fiecare argument:
#  - daca argumentul este un director, afisati toate numele de fisiere recursiv din director care contin cel putin 5 linii de text
#  - daca argumentul este un fisier regular al carui nume se termina cu ".sh", afisati primele 5 linii din fisier

#!/bin/bash

for arg in $@; do
	if [ -d $arg ]; then
		echo "$arg is a directory"
		find $arg -type f | while read -r file; do
			if [ $(grep -E -c "" $file) -ge 5 ]; then
				echo "$file"
			fi
		done
	elif [ -f $arg ]; then
		echo "$arg is a file"
		if [ ! $(ls $arg | grep -E -c "\.sh$") -eq 0 ]; then
			echo $(cat $arg | head -n 5)
		else
			echo "$arg is not a shell file"
		fi
	else
		echo "$arg is not a file nor a directory"
	fi
done

