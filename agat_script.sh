#!/bin/bash
#SBATCH --partition=investor_bg4
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --mem=10G
#SBATCH --time=5:00:00
#SBATCH --job-name=agat


module load python/anaconda/3.12.7

source activate agat_env

#run this line for saxatilis 
#agat_convert_sp_gff2gtf.pl --gff ~/Eirlys_Files/new_run_eggnog/a_saxatilis/a_saxatilis.emapper.decorated.gff -o ~/Eirlys_Files/new_run_eggnog/a_saxatilis/a_saxatilis.emapper.decorated.gtf

#run this line for troschelii
agat_convert_sp_gff2gtf.pl --gff ~/Eirlys_Files/new_run_eggnog/a_troschelii/a_troschelii.emapper.decorated.gff -o ~/Eirlys_Files/new_run_eggnog/a_troschelii/a_troschelii.emapper.decorated.gtf

conda deactivate
