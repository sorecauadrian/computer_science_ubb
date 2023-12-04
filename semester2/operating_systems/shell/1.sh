#!/bin/bash
cat who.fake | awk '{print $1}' | while read user
do
	counter=`cat ps.fake | grep -E "^$user" | wc -l`
	echo "$user $counter"
done
