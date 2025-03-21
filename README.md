# Transisthmian-Abudefduf-RNAseq
Repository for project comparing the response of A. saxatilis vs. A. troschelii to heatwave, control, and cold-water upwelling temperature conditions. 


Overview

Installing AGAT as a conda virtual environment

```
module load python/anaconda/3.12.7
conda create -n agat_env
conda activate agat_env
conda install -c bioconda agat
source deactivate

```

Run AGAT to convert gff to gtf

```
sbatch agat_script.sh
```

Run hisat2 to create an index for each genome and map trimmed reads

Run stringtie 

Run prepDE

