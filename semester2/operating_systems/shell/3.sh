#!/bin/bash

aux="auxiliar"

find $1 -type f -name "*.log" | while read file; do
	cat $file | sort > $aux
	mv $aux $file
done
	
