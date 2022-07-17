#!/bin/bash
con_string=""
blueprint=$(cat "plot_blueprint.p")
body=${blueprint%PLOT_FILES*}
files=${blueprint#*PLOT_FILES}
imp_files=${files#*PLOT_CURRENT}
unimp_files=${files%PLOT_CURRENT*}
#only_important=${blueprint%ADDENDUM*}
#only_unimportant=${blueprint#*ADDENDUM}
unimportant_plot_commands=""
for abbreviation_and_name in "baseline baseline" "buiNeiPar neighborList" "pbcPar updatePbc" "binAtPar binAtoms" "upAtPar updateAtomsPbc";
do
	set -- $abbreviation_and_name
	filenam=$1
	fancy_name=$2
	fil_a40="a40_gpu1-32_sr_t200_DP_"$filenam"_condensed.csv"
	fil_a100="a100_gpu1-32_sr_t200_DP_"$filenam"_condensed.csv"
	script=$(echo "$body" | sed "s/OUT_FILENAME/plot_upto_$filenam/")
	important_plots=$(echo "$imp_files" \
	| sed "s/A40_IMPORTANT_DAT/$fil_a40/" | sed "s/A40_IMPORTANT_LEGEND/A40 DP $fancy_name/" \
	| sed "s/A100_IMPORTANT_DAT/$fil_a100/" | sed "s/A100_IMPORTANT_LEGEND/A100 DP $fancy_name/")
	script_filename="plotscript_upto_""$filenam"".p"
	echo "$script_filename"
	echo "$script$unimportant_plot_commands$important_plots" > "$script_filename"
	unimportant_plot_commands+=$(echo "$unimp_files" \
        | sed "s/A40_UNIMPORTANT_DAT/$fil_a40/" | sed "s/A40_UNIMPORTANT_LEGEND/A40 DP $fancy_name/" \
        | sed "s/A100_UNIMPORTANT_DAT/$fil_a100/" | sed "s/A100_UNIMPORTANT_LEGEND/A100 DP $fancy_name/")
done
