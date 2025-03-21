#!/bin/bash
#SBATCH --partition=investor_bg4
#SBATCH --ntasks=48
#SBATCH --mem=50G
#SBATCH --time=2-00:00:00
#SBATCH --job-name=hisat2
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=cbt0022@easley.auburn.edu
#SBATCH --output=job-%j.out          # Output file. %j is replaced with job ID
#SBATCH --error=job-%j.err           # Error file. %j is replaced with job ID

module load gffreader
module load gcc/9.3.0
module load hisat2/2.2.1
module load samtools/1.19

#convert gff to gtf
#cd ~/Eirlys_Files/new_run_eggnog/a_saxatilis/
#gffread -E a_saxatilis.emapper.decorated.gff -T -o a_saxatilis.emapper.decorated.gtf

#asax_gtf=~/Eirlys_Files/new_run_eggnog/a_saxatilis/a_saxatilis.emapper.decorated.gtf

cd genome_index_hisat
#ID splice site
#hisat2_extract_splice_sites.py ~/Eirlys_Files/new_run_eggnog/a_saxatilis/a_saxatilis.emapper.decorated.gtf > A_sax_splice_sites.hisat


#ID exons
#hisat2_extract_exons.py ~/Eirlys_Files/new_run_eggnog/a_saxatilis/a_saxatilis.emapper.decorated.gtf > A_sax_exons.hisat


#Splice site informed index
#hisat2-build -p 40 --ss A_sax_splice_sites.hisat --exon A_sax_exons.hisat ~/A-sax-genome/analysis/asax_assembly.asm.p_ctg.fa A_sax_genome

# Now that we have our index built, let's run HISAT2 to map the reads from each sample to our genome.
# We'll loop through all of our samples like we did with the trimmomatic script.
samplelist="S_C_M_E26 S_C_M_E27 S_C_M_E28 S_C_M_E30 S_C_M_E56 S_C_M_E57 S_C_M_E58 S_C_M_E59 S_U_M_E16 S_U_M_E18 S_U_M_E19 S_U_M_E46 S_U_M_E47 S_U_M_E48 S_U_M_E49 S_U_M_E50 S_W_M_E06 S_W_M_E07 S_W_M_E08 S_W_M_E36 S_W_M_E37 S_W_M_E38 S_W_M_E39 S_W_M_E40"

# For each sample in our list:
# first run was done on 3/20/25 mapping to the A sax genome, however these had generally lower overall alignment rates
# 3/21/25: trying a cross alignment to the troschelii reference genome to see if they get higher or similar rates to the troschelii rna
for sample in ${samplelist}
do
        # We'll run hisat2 to align our cleaned reads to the A. polyacanthus genome
        # -p tells the program to run on 8 threads
        # -k tells the program to only search for a maximum of 3 alignments per read. We're only going to continue our analysis with reads that mapped uniquely (i.e., 1 time), so this makes sure the program doesn't spend a bunch of extra time aligning multi-mapping reads
        # -x is the flag that we use to specify the "base name" of our index files
        # -1 is the flag that we use to specify the fastq file containing our mate1 reads
        # -2 is the flag that we use to specify the fastq file containing our mate2 reads
        # After we've created our alignments, we're going to pipe the output of that command to the program samtools, which will convert our output from a .SAM format to a binary .BAM format. The file will encode the same information, but it takes up less space.
        
        #USE ONE OF THE TWO FOLLOWING OPTIONS DEPENDING ON HOW YOU WANT TO MAP YOUR READS
        #use this line if mapping to saxatilis
        #hisat2 -p 48 -k 3 -x A_sax_genome -1 /scratch/cbt0022/Panama_Exp_RNAseq/filtered_fastq_paired/${sample}_1_paired.fq.gz -2 /scratch/cbt0022/Panama_Exp_RNAseq/filtered_fastq_paired/${sample}_2_paired.fq.gz | samtools view -@ 8 -Sbh > /scratch/cbt0022/Panama_Exp_RNAseq/mapping_hisat/${sample}.bam

        #use this line if mapping to troschelii 
        hisat2 -p 48 -k 3 -x A_tro_genome -1 /scratch/cbt0022/Panama_Exp_RNAseq/filtered_fastq_paired/${sample}_1_paired.fq.gz -2 /scratch/cbt0022/Panama_Exp_RNAseq/filtered_fastq_paired/${sample}_2_paired.fq.gz | samtools view -@ 8 -Sbh > /scratch/cbt0022/Panama_Exp_RNAseq/mapping_hisat/${sample}.bam
        
        # We'll use samtools to sort our output alignment (the binary .BAM file), which is necessary to prepare it for the next program we want to use
        samtools sort -@ 8 -o /scratch/cbt0022/Panama_Exp_RNAseq/mapping_hisat/${sample}_sorted.bam /scratch/cbt0022/Panama_Exp_RNAseq/mapping_hisat/${sample}.bam
        # Delete the unsorted bam file so it's not taking up unnecessary space
        rm /scratch/cbt0022/Panama_Exp_RNAseq/mapping_hisat/${sample}.bam
        # Index our sorted bam file, which is necessary for the next program we want to use
        samtools index /scratch/cbt0022/Panama_Exp_RNAseq/mapping_hisat/${sample}_sorted.bam
done
