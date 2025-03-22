# Transisthmian-Abudefduf-RNAseq
Repository for project comparing the response of A. saxatilis vs. A. troschelii to heatwave, control, and cold-water upwelling temperature conditions. 


Overview

1. Initial QC - run fastqc.sh
2. Trimmomatic - run trimmomatic.sh
3. Post Trim QC - run fastqc_posttrim.sh
4. Installing AGAT as a conda virtual environment

```
module load python/anaconda/3.12.7
conda create -n agat_env
conda activate agat_env
conda install -c bioconda agat
source deactivate

```

5. Run AGAT to convert gff to gtf

```
sbatch agat_script.sh
```

6. Run hisat2 to create an index for each genome and map trimmed reads
7. Run stringtie
8. Run prepDE from within DE folder

```
which python #confirm python 3

module load python/3.9.2

#this will combine ALL samples within the stringtie_results folder into  gene and trnascript count matrices
python prepDE.py3 -i ../stringtie_results/ -g gene_count_matrix.csv -t transcript_count_matrix.csv

```
