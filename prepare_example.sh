#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

example_data_dir="$SCRIPTDIR/example_data"
example_run_dir="$SCRIPTDIR/example_run"

dl_files=("S288C_Nanopore_R7.fastq.gz", "S288C_Nanopore_R9.fastq.gz", "S288C_illumina_1.fastq.gz", "S288C_illumina_2.fastq.gz")
dl_prefix="http://www.genoscope.cns.fr/externe/Download/Projets/yeast/datasets/raw_data/S288C"
for file in ${dl_files[@]}; do
  wget $dl_prefix/$file -O $example_data_dir/$file
  gunzip $example_data_dir/$file
#efor

grep 'template'      -A 3 $example_data_dir/S288C_Nanopore_R7.fastq > $example_data_dir/S288C_Nanopore_R7_1d.fastq
grep 'twodirections' -A 3 $example_data_dir/S288C_Nanopore_R7.fastq > $example_data_dir/S288C_Nanopore_R7_2d.fastq 

grep 'template'      -A 3 $example_data_dir/S288C_Nanopore_R9.fastq > $example_data_dir/S288C_Nanopore_R9_1d.fastq
grep 'twodirections' -A 3 $example_data_dir/S288C_Nanopore_R9.fastq > $example_data_dir/S288C_Nanopore_R9_2d.fastq

mkdir -p $example_run_dir
yes | ./gen_pipeline $example_data_dir/PTSV.tsv $example_data_dir $example_run_dir

