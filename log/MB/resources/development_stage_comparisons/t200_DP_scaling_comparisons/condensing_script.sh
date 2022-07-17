#!/bin/bash
for filenam in $(ls | grep sr)
do
	out_file=$(echo $filenam | sed 's/\.o[0-9]\{6\}/_condensed.csv/')
	cat $filenam | grep e6 > $out_file
done
