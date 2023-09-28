#! /bin/bash

count_files=0
count_lines=0

find $1 -type f | while read file; do
	current_number_of_lines=$(cat $file|wc -l)
	count_lines=$((count_lines + current_number_of_lines))
	count_files=$((count_files + 1))
done 
echo $((count_lines / count_files))
