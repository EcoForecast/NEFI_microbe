
#!/bin/bash -l

#$ -l h_rt=120:00:00

#$ -N DNA_QC

#$ -m ae

cd /usr4/spclpgm/bhackos

module load miniconda/4.5.12

source activate sunbeam-tmp.pkm3BCVHjt

unset PYTHONPATH

sunbeam run -- --configfile /projectnb/talbot-lab-data/NEFI_data/metagenomes/2017_project/sunbeam_config.yml all_qc


