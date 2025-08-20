# Transisthmian-Abudefduf-RNAseq
Repository for manuscript comparing the response of A. saxatilis vs. A. troschelii to heatwave, control, and cold-water upwelling temperature conditions. The comparison is of differential gene expression of muscle tissue resulting from an aquarium experiment run at Smithsonian Tropical Research Institute by Claire B. Tracy, Laura Lardinois, and Caitlin (Cricket) McNally. 


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

9. Run DEseq2 on output from prepDE, configuring your random effects and variable of interest according to your analysis.
10. Run WGCNA
