
#!/bin/bash -l

#$ -l h_rt=120:00:00

#$ -l mem_total=9G -pe omp 28

#$ -N DNA_co-assembly_28

#$ -m ae

cd /usr4/spclpgm/bhackos

module load miniconda/4.5.12

source activate sunbeam-tmp.pkm3BCVHjt

unset PYTHONPATH

sunbeam run -- --configfile /projectnb/talbot-lab-data/NEFI_data/metagenomes/my_project_short/sunbeam_config.yml --unlock all_coassemble

sunbeam run -- --configfile /projectnb/talbot-lab-data/NEFI_data/metagenomes/my_project_short/sunbeam_config.yml all_coassemble


