#!/usr/bin/bash

# file: auto_var_call_script.sh
# Created by Ryan Kyger
# Tools: bwa ?, samtools ?, bcftools ?
# Description: This script takes reference and read files as input from the user, QC's the files, aligns the files with BWA, sorts the output SAM file, performs variant calling, and provides basic variant calling statisitcs.   
##############################################################################################################

# Usage: bash auto_var_call_script.sh <path/filename to BWA reference> <filename of 1st set of reads> <filename of 2nd set of reads>
# Example: 

##############################################################################################################
# User input of path/filename of BWA reference is stored as ref
echo "------------------------------------------------------------------------------------------------------"
echo "User input check ..."
echo ""
ref=$1
echo "BWA reference: $ref"
echo ""

# User input of filename of 1st set of reads is stored as read_1
read_1=$2
echo "1st read pair: $read_1"
echo ""

# User input of filename of 2nd set of reads is stored as read_2
read_2=$3
echo "2nd read pair: $read_2"
echo ""

# extract basename of input fastq files
basename=${read_1%_*}
echo "basename of fastq files: $basename"
echo ""

echo "input check done"
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
# QC and trim fastq files
echo "Starting QC ..."
echo ""

fastp -i ${basename}_1.fastq.gz -I ${basename}_2.fastq.gz -o ${basename}_1.fp.fastq.gz -O ${basename}_2.fp.fastq.gz

echo ""
echo "QC complete, clean fastq's are" ${basename}_1.fp.fastq.gz ${basename}_2.fp.fastq.gz
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
echo "Indexing reference ..."
echo ""

# index reference genome for bwa
bwa index $ref

echo "Indexing complete"
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
# Run BWA alignment and create bam file as output
echo "Starting alignment ..."
echo ""

# Run BWA alignment
bwa mem -t 8 $ref ${basename}_1.fp.fastq.gz ${basename}_2.fp.fastq.gz | samtools view -Sb - > ${basename}.bam

echo ""
echo "Alignment complete, output file is" ${basename}.bam
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
echo "Extracting properly paired reads ..."
echo ""

# extract properly paired reads
samtools view -b -f 0x2 ${basename}.bam > ${basename}.pp.bam

echo "Extraction complete, output file is" ${basename}.pp.bam
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
echo "Removing duplicates ..."
echo ""

# REMOVE DUPLICATES
# sort by name 
samtools sort -n ${basename}.pp.bam -o ${basename}.nsorted.pp.bam
# add mate score tags for markdup to use
samtools fixmate -m ${basename}.nsorted.pp.bam ${basename}.fm.nsorted.pp.bam
# sort by coordinates
samtools sort ${basename}.fm.nsorted.pp.bam -o ${basename}.fm.csorted.pp.bam
# remove duplicates 
samtools markdup -r ${basename}.fm.csorted.pp.bam ${basename}.dedup.fm.csorted.pp.bam

echo "Duplicates removal complete, output file is" ${basename}.dedup.fm.csorted.pp.bam
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
echo "Extracting reads with map quality of 30 or higher ..."
echo ""

# extract reads with a map quality of 30 or higher
samtools view -b -q 30 ${basename}.dedup.fm.csorted.pp.bam > ${basename}.q30.dedup.fm.csorted.pp.bam

echo "Extraction complete, output file is" ${basename}.q30.dedup.fm.csorted.pp.bam
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
echo "Indexing bam file ..."
echo ""

# index .bam file for variant calling
samtools index ${basename}.q30.dedup.fm.csorted.pp.bam

echo "Indexing complete"
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
echo "Getting bam file stats..."
echo ""

# Get stats for bam file 
samtools stats ${basename}.q30.dedup.fm.csorted.pp.bam > ${basename}_bam_stats.txt

echo "Output file with stats is" ${basename}_bam_stats.txt
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
echo "Starting variant calling, with filter for DP > 30 ..."
echo ""

# run variant calling
# note: change DP, or ploidy, if necessary, for haploid: --ploidy 1
# ex: freebayes -f $ref --ploidy 1 ${basename}.q30.dedup.fm.csorted.pp.bam | vcffilter -f "DP > 30" > ${basename}_variants_dp30.vcf.gz
freebayes -f $ref --ploidy 1 ${basename}.q30.dedup.fm.csorted.pp.bam | vcffilter -f "DP > 30" > ${basename}_variants_dp30.vcf.gz

echo "Variant calling complete, output file is" ${basename}_variants_dp30.vcf.gz
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################
echo "Get variant calling stats ..."
echo ""

# get variant calling stats
bcftools stats ${basename}_variants_dp30.vcf.gz > ${basename}_variant_stats.txt

echo "Output file with stats is" ${basename}_variant_stats.txt
echo "------------------------------------------------------------------------------------------------------"
##############################################################################################################

