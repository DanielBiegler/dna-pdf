#!/bin/bash
if [ $# -lt 5 ]; then
	echo "You need 5 arguments: start_line, end_line, /path/genome.fna, fold-width, /path/output"
	exit 1
fi

# $1: Start line, inclusive
# $2: End line, inclusive
# $3: Path to the DNA Data in fasta file format
# $4: Fold width to properly fit the page
# $5: Path to output content file
sed -n "$1,$2p;$(($2+1))q" $3 | grep -v '^>' | tr -d '\nNn' | fold -w $4 | sed 's/^/<text:p text:style-name="P2">/' | sed 's/$/<\/text:p>/' > $5
