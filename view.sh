#remove wrap around
less -S

# remove header (-h) and wrap around
samtools view -h file.bam | less -S
