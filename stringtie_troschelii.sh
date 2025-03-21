#!/bin/bash
#SBATCH --partition=investor_bg4
#SBATCH --ntasks=48
#SBATCH --nodes=1
#SBATCH --mem=50G
#SBATCH --time=10:00:00
#SBATCH --job-name=stringtie



module load stringtie

#mkdir stringtie_results

#entire sample list
samplelist="T_C_M_E21 T_C_M_E22 T_C_M_E25 T_C_M_E51 T_C_M_E52 T_C_M_E53 T_C_M_E54 T_C_M_E55 T_U_M_E12 T_U_M_E14 T_U_M_E15 T_U_M_E41 T_U_M_E42 T_U_M_E43 T_U_M_E44 T_U_M_E45 T_W_M_E03 T_W_M_E04 T_W_M_E05 T_W_M_E31 T_W_M_E32 T_W_M_E33 T_W_M_E34 T_W_M_E35"



for sample in ${samplelist}
do
        mkdir stringtie_results/${sample}
        stringtie -p 48 -e -B -G ~/Eirlys_Files/new_run_eggnog/a_troschelii/a_troschelii.emapper.decorated.gtf -o stringtie_results/${sample}/${sample}.gtf mapping_hisat/${sample}_sorted.bam
done
