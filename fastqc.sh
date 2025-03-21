#!/bin/bash
#SBATCH --partition=investor_bg4
#SBATCH --ntasks=20
#SBATCH --mem=40G
#SBATCH --nodes=1
#SBATCH --time=10:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=cbt0022@auburn.edu

module load java/15.0.1
module load fastqc/0.12.0


#run the following commands, the first set for the first batch of data, and the second set for the second batch of data. 
cd usftp21.novogene.com/01.RawData/
fastqc */*.fq.gz -t 20 -o /scratch/cbt0022/Panama_Exp_RNAseq/raw_reports/

cd RNA-seq-Second-run-Feb2025/01.RawData/
fastqc */*.fq.gz -t 8 -o /scratch/cbt0022/Panama_Exp_RNAseq/raw_reports/
