#!/bin/bash
#SBATCH --partition=investor_bg4
#SBATCH --ntasks=48
#SBATCH --nodes=1
#SBATCH --mem=50G
#SBATCH --time=10:00:00
#SBATCH --job-name=stringtie



module load stringtie

mkdir stringtie_results

#sample list
samplelist="S_C_M_E26 S_C_M_E27 S_C_M_E28 S_C_M_E30 S_C_M_E56 S_C_M_E57 S_C_M_E58 S_C_M_E59 S_U_M_E16 S_U_M_E18 S_U_M_E19 S_U_M_E46 S_U_M_E47 S_U_M_E48 S_U_M_E49 S_U_M_E50 S_W_M_E06 S_W_M_E07 S_W_M_E08 S_W_M_E36 S_W_M_E37 S_W_M_E38 S_W_M_E39 S_W_M_E40"


#first run with -G giving the gff file (according to katies script). other script gives gtf so trying that
for sample in ${samplelist}
do
        mkdir stringtie_results/${sample}
        stringtie -p 48 -e -B -G ~/Eirlys_Files/new_run_eggnog/a_saxatilis/a_saxatilis.emapper.decorated.gtf -o stringtie_results/${sample}/${sample}.gtf mapping_hisat/${sample}_sorted.bam
done
