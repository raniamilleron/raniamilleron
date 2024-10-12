#!/usr/bin/env bash

input_file="sequences.txt"

while read -r sequence
do
	echo "Sequence: $sequence"  # print the current sequence to the console

	# Calculate the GC content

    	total_length=${#sequence}

    	gc_count=$(echo -n "$sequence" | tr -cd 'GC' | wc -m)

    	gc_content=$(awk "BEGIN { printf \"%.2f\", ($gc_count / $total_length) * 100 }")



    	echo "GC content: $gc_content%"  # print the GC content to the console

done < "$input_file"
