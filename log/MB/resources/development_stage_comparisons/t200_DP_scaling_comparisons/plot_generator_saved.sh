#!/bin/bash
con_string=""
blueprint=$(cat "plot_blueprint.p")
only_important=${blueprint%ADDENDUM*}
only_unimportant=${blueprint#*ADDENDUM}
unimportant_plot_commands=""
for abbreviation_and_name in "baseline baseline" "buiNeiPar buildNeighbor-Parallilization" "pbcPar updatePbc-Parallelization" "binAtPar binAtoms-Parallelization" "upAtPar updateAtomsPbc-Parallelization";
do
	set -- $abbreviation_and_name
	filenam=$1
	fancy_name=$2
	fil_a40="a40_gpu1-32_sr_t200_DP_"$filenam"_condensed.csv"
	fil_a100="a100_gpu1-32_sr_t200_DP_"$filenam"_condensed.csv"
	script=$(echo "$only_important" | sed "s/OUT_FILENAME/plot_upto_$filenam/"\
	| sed "s/A40_IMPORTANT_DAT/$fil_a40/" | sed "s/A40_IMPORTANT_LEGEND/A40 DP $fancy_name/" \
	| sed "s/A100_IMPORTANT_DAT/$fil_a100/" | sed "s/A100_IMPORTANT_LEGEND/A100 DP $fancy_name/")
	script_filename="plotscript_upto_""$filenam"".p"
	echo "$script_filename"
	echo "$script$unimportant_plot_commands" > "$script_filename"
	unimportant_plot_commands+=$(echo "$only_unimportant" \
        | sed "s/A40_UNIMPORTANT_DAT/$fil_a40/" | sed "s/A40_UNIMPORTANT_LEGEND/A40 DP $fancy_name/" \
        | sed "s/A100_UNIMPORTANT_DAT/$fil_a100/" | sed "s/A100_UNIMPORTANT_LEGEND/A100 DP $fancy_name/")
done
