#!/bin/bash -l 

#$ -l h_rt=120:00:00

#$ -l mem_total=125G -pe omp 16

#$ -N NYyc_Search

#$ -m ae

cd /usr4/spclpgm/bhackos

cd /projectnb/talbot-lab-data/NEFI_data/metagenomes/my_project_short/NCyc/

module load usearch/8.1.1756

perl NCycProfiler.PL -d /projectnb/talbot-lab-data/NEFI_data/metagenomes/my_project_short/03_CONTIGS -m usearch -f fa -s nucl -si /projectnb/talbot-lab-data/NEFI_data/metagenomes/my_project_short/NCyc_si.tsv -o /projectnb/talbot-lab-data/NEFI_data/metagenomes/my_project_short/NCyc_out.txt