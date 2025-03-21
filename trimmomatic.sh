#!/bin/bash

#SBATCH --partition=investor_bg4
#SBATCH --ntasks=40
#SBATCH --nodes=1
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trimmomatic


module load java
module load trimmomatic

#sample list for batch of data from first run. 
samplelist="S_C_M_E26 S_C_M_E27 S_C_M_E28 S_C_M_E30 S_C_M_E56 S_C_M_E57 S_C_M_E58 S_C_M_E59 S_U_M_E16 S_U_M_E18 S_U_M_E19 S_U_M_E46 S_U_M_E47 S_U_M_E48 S_U_M_E49 S_U_M_E50 S_W_M_E36 S_W_M_E37 S_W_M_E38 S_W_M_E39 S_W_M_E40 T_C_M_E21 T_C_M_E22 T_C_M_E25 T_C_M_E51 T_C_M_E52 T_C_M_E53 T_C_M_E54 T_C_M_E55 T_U_M_E12 T_U_M_E14 T_U_M_E15 T_U_M_E41 T_U_M_E42 T_U_M_E43 T_U_M_E44 T_U_M_E45 T_W_M_E05 T_W_M_E31 T_W_M_E32 T_W_M_E33 T_W_M_E34 T_W_M_E35"

#sample list for batch of data from second run
samplelist="S_W_M_E06 S_W_M_E07 S_W_M_E08 T_W_M_E03 T_W_M_E04"

cd usftp21.novogene.com/01.RawData/
cd RNA-seq-Second-run-Feb2025/01.RawData/


for sample in ${samplelist}
do
    cd ${sample}/
    java -jar $TRIMMOMATIC PE -threads 40 -phred33 \
    ${sample}_1.fq.gz ${sample}_2.fq.gz \
    ${sample}_1_paired.fq.gz ${sample}_1_unpaired.fq.gz \
    ${sample}_2_paired.fq.gz ${sample}_2_unpaired.fq.gz \
    ILLUMINACLIP:/tools/trimmomatic-0.39/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:4 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:40
    cd ..
done
