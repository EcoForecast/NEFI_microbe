#qsub file for Sunbeam Report Extension

#!/bin/bash -l

#$ -l h_rt=120:00:00

#$ -l mem_total=125G -pe omp 16

#$ -N DNA_report

#$ -m ae

cd /usr4/spclpgm/bhackos

cd /projectnb/talbot-lab-data/NEFI_data/my_project2

module load miniconda/4.5.12

source activate sunbeam-tmp.pkm3BCVHjt

unset PYTHONPATH

sunbeam run --configfile=sunbeam_config.yml --use-conda all_reports