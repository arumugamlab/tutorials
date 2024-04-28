# PIG-PARADIGM Shotgun metagenomics workshop - Afternoon session
### 29.04.2024

We are going to run a pre-made pipeline, called [MIntO](https://github.com/arumugamlab/MIntO), to go from trimmed sequencing reads to fully annotated genomes.

## Setup for running MIntO
Note: If you lose connection to the server and re-login, these following steps need to be repeated.

Activate the pre-installed conda virtual environment and define some shell environment variables:
```bash
source activate MIntO
export MINTO_DIR="$HOME/MIntO"
export PROJ_DIR="$HOME/tutorial"
```

Go to the folder where we already run some preparatory parts of MIntO:
```bash
cd $PROJ_DIR
cd metaG
```

Look around in the folder! Note the structure of the directories.

Next, define some Snakemake parameters, to use conda environments and limit resources:
```bash
SNAKE_PARAMS="--use-conda --restart-times 1 --keep-going --latency-wait 60 --jobs 10 --cores 16 --resources mem=58 --conda-prefix $MINTO_DIR/conda_env --shadow-prefix $PWD/.snakemake"
```

Copy metadata file from the MIntO repository's tutorial folder:
```bash
cp $MINTO_DIR/tutorial/metadata/tutorial_metadata.txt .
```

## Start MIntO

### Run assembly.smk
```bash
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/assembly.smk --configfile assembly.yaml
```

### Run binning_preparation.smk
```bash
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/binning_preparation.smk --configfile assembly.yaml
```

### Run mags_generation.smk
First, modify the configuration file, to switch off taxonomical annotation by the pipeline.
```bash
sed "s/RUN_TAXONOMY: yes/RUN_TAXONOMY: no/" mags_generation.yaml | grep -v "aae" > mags_generation.yaml.fixed
```

Now, we can run the binning step:
```bash
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/mags_generation.smk --configfile mags_generation.yaml.fixed
```

### Run gene_annotation.smk

Like in the last step, we need to modify the standard configuration file for this step, mapping.yaml, to only do the annotation with KEGG:
```bash
sed -e "s|/mypath|$HOME|; s|/IBD_tutorial|/tutorial|; s|dbCAN|KEGG|; s|BWA_threads: 10|BWA_threads: 8|; s|BWA_memory: 45|BWA_memory: 10|" $MINTO_DIR/configuration/mapping.yaml | grep -v eggNOG > mapping.yaml

```
Thereafter, we can run gene_annotation.smk:
```bash
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/gene_annotation.smk --configfile mapping.yaml
```

Outputs will be created in `$PROJ_DIR/DB` folder

### If we have time also run these

Run gene abundance estimation, using the MAGs:
```bash
snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/gene_abundance.smk --configfile mapping.yaml
```

Collect outputs from the metagenomics data:
```bash
cd $PROJ_DIR

egrep -v " (eggNOG|dbCAN|eCAMI|KEGG|PFAMs)" data_integration.yaml | sed "s/metaG_metaT/metaG/" > data_integration.yaml.fixed

snakemake $SNAKE_PARAMS --snakefile $MINTO_DIR/smk/data_integration.smk --configfile data_integration.yaml.fixed
```
