#!/bin/bash
for tup in "upAt updateAtomsPbc" "setupPbc setupPbc" "upPbc updatePbc" "binAtoms binAtoms" "buiNeiList buildNeighborLists"
do
	set -- $tup
	cat "plot_blueprint.p" | sed "s/upAt/$1/" | sed "s/updateAtomsPbc/$2/" > "plotscript_""$1"".p"
done
