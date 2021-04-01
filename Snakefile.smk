# snakemake test run with variant calling (based on snakemake tutorial)
# dry run: snakemake -np --snakefile Snakefile.smk
# run: snakemake --cores 2 --snakefile Snakefile.smk

# example: SAMPLES = ["A", "B"]

# set all rule relative to final output
rule all:
    input:
        "SRR341549_bcf.vcf.gz"

# QC and trim fastq files with fastp
rule qc_fastp:
    input:
        r1="SRR341549_1.fastq.gz",
        r2="SRR341549_2.fastq.gz"
    output:
        o1="SRR341549_1.fp.fastq.gz",
        o2="SRR341549_2.fp.fastq.gz"
    shell:
        "fastp -i {input.r1} -I {input.r2} -o {output.o1} -O {output.o2}"

# align sequences with bwa
rule bwa_map:
    input:
        "E.coli_K12_MG1655.fa",
        "SRR341549_1.fp.fastq.gz",
        "SRR341549_2.fp.fastq.gz"
    output:
        "SRR341549.bam"
    shell:
        # align and convert sam to bam
        "bwa mem {input} | samtools view -Sb - > {output}"

# sort bam files
rule samtools_sort:
    input:
        "SRR341549.bam"
    output:
        "SRR341549.sorted.bam"
    shell:
        # sort by coordinates
        "samtools sort {input} -o {output}"

# index bam files
rule samtools_index:
    input:
        "SRR341549.sorted.bam"
    output:
        "SRR341549.sorted.bam.bai"
    shell:
        "samtools index {input}"

# run variant calling with bcftools 
rule bcftools_call:
    input:
        fa="E.coli_K12_MG1655.fa",
        bam="SRR341549.sorted.bam",
        bai="SRR341549.sorted.bam.bai"
    output:
        "SRR341549_bcf.vcf.gz"
    shell:
        "bcftools mpileup -Ou -f {input.fa} {input.bam} | bcftools call -vmO z --ploidy 1 -o {output}"
