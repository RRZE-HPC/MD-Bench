#!/bin/bash
for name in "force" "upAt" "setupPbc" "upPbc" "binAtoms" "buiNeiList"
do
	file="plotscript_""$name"".p"
	echo "$file"
	gnuplot "$file"
done
