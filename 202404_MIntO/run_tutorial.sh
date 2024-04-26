#!/usr/bin/env bash

source activate MIntO
export MINTO_DIR="$HOME/MIntO"
export PROJ_DIR="$HOME/tutorial"

SNAKE_PARAMS="--use-conda --restart-times 1 --keep-going --latency-wait 60 --jobs 10 --cores 16 --resources mem=58 --conda-prefix $MINTO_DIR/conda_env --shadow-prefix $PWD/.snakemake"

# Set up metadata
cd $PROJ_DIR
cp $MINTO_DIR/tutorial/metadata/tutorial_metadata.txt .

# Start MIntO

cd metaG
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/assembly.smk --configfile assembly.yaml

snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/binning_preparation.smk --configfile assembly.yaml

sed "s/RUN_TAXONOMY: yes/RUN_TAXONOMY: no/" mags_generation.yaml | grep -v "aae" > mags_generation.yaml.fixed
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/mags_generation.smk --configfile mags_generation.yaml.fixed 

## PROVIDE mapping.yaml
sed -e "s|/mypath|$HOME|; s|/IBD_tutorial|/tutorial|; s|dbCAN|KEGG|; s|BWA_threads: 10|BWA_threads: 8|; s|BWA_memory: 45|BWA_memory: 10|" $MINTO_DIR/configuration/mapping.yaml | grep -v eggNOG > mapping.yaml
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/gene_annotation.smk --configfile mapping.yaml
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/gene_abundance.smk --configfile mapping.yaml

cd ..

egrep -v " (eggNOG|dbCAN|eCAMI|KEGG|PFAMs)" data_integration.yaml | sed "s/metaG_metaT/metaG/" > data_integration.yaml.fixed
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/data_integration.smk --configfile data_integration.yaml.fixed
