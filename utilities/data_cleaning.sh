#1/usr/bin/env bash
# Use Linux command line to extract sequence headers from this multi-FASTQ file

$ grep "@" SRR30787173.fastq | sed 's/@//' | sort | uniq | cut -d " " -f1 > finalIDsFastq.txt

# Use Linux command line to extract speciic columns (e.g., gene names, coordinates, or read counts).
# Filter data based on patterns (e.g., sequences with specific properties).
# Summarizing datasets (e.g., calculating averages or totals).
awk '/^>/ { print $0 }' sequences.fasta

# Generic code for finding files
find . -iname '*.txt' | while read f; do ls -l "$f";file "$f";done

# Specific example of code for finding files in biofinformatics
find . -iname '*.fasta' | while read f; do ls -l "$f"; file "$f"; done
