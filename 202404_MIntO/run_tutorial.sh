#!/usr/bin/env bash

source activate MIntO
export MINTO_DIR="$HOME/MIntO"
export PROJ_DIR="$HOME/tutorial"

cd $PROJ_DIR
cd metaG

# Set up Snakemake parameters
SNAKE_PARAMS="--use-conda --restart-times 1 --keep-going --latency-wait 60 --jobs 10 --cores 16 --resources mem=58 --conda-prefix $MINTO_DIR/conda_env --shadow-prefix $PWD/.snakemake"

# Set up metadata
cp $MINTO_DIR/tutorial/metadata/tutorial_metadata.txt .

# Set up patched yaml file for assembly
cp $MINTO_DIR/configuration/assembly.yaml .
curl https://raw.githubusercontent.com/arumugamlab/tutorials/main/202404_MIntO/minto_install.sh | patch -i - assembly.yaml

# Start MIntO

# This takes 7.5 mins
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/assembly.smk --configfile assembly.yaml

# This takes 8.5 mins
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/binning_preparation.smk --configfile assembly.yaml

sed "s/RUN_TAXONOMY: yes/RUN_TAXONOMY: no/" mags_generation.yaml | grep -v "aae" > mags_generation.yaml.fixed

# This takes 10 mins
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/mags_generation.smk --configfile mags_generation.yaml.fixed 

## PROVIDE mapping.yaml
sed -e "s|/mypath|$HOME|; s|/IBD_tutorial|/tutorial|; s|dbCAN|KEGG|; s|BWA_threads: 10|BWA_threads: 8|; s|BWA_memory: 45|BWA_memory: 10|" $MINTO_DIR/configuration/mapping.yaml | grep -v eggNOG > mapping.yaml
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/gene_annotation.smk --configfile mapping.yaml
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/gene_abundance.smk --configfile mapping.yaml

cd ..

egrep -v " (eggNOG|dbCAN|eCAMI|KEGG|PFAMs)" data_integration.yaml | sed "s/metaG_metaT/metaG/" > data_integration.yaml.fixed
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/data_integration.smk --configfile data_integration.yaml.fixed

rm -rf 6-mapping/
rm -rf 8-1-binning/
rm -rf 7-assembly/CD244/
rm -rf 7-assembly/CD2/
rm -rf 7-assembly/CD1/meta-large/intermediate_contigs.tar.gz
rm -rf 7-assembly/CD*/k21-99/{K??,assembly_graph*,before_rr.fasta,misc,first_pe_contigs.fasta,strain_graph.gfa}
