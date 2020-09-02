# -*- coding: utf-8 -*-
"""
Created on Mon Sep  2 12:53:05 2019

@author: Ryan
"""

from Bio.Seq import Seq
from Bio.Alphabet import IUPAC

#coding strand / S1
coding_dna = Seq("ATGGCCATTGTAATGGGCCGCTGAAAGGGTGCCCGATAG", IUPAC.unambiguous_dna)
print(coding_dna)

#template strand
template_dna = coding_dna.complement()
print(template_dna)

#DNA to mRNA / S2
messenger_rna = coding_dna.transcribe()
print(messenger_rna)

#mRNA to DNA
rev_transcription = messenger_rna.back_transcribe()
print(rev_transcription )

#mRNA to protein / S3
protein = messenger_rna.translate()
print(protein)

# directly from DNA to protein
protein2 = coding_dna.translate()
print(protein2)


from Bio.Data import CodonTable
standard_table = CodonTable.unambiguous_dna_by_name["Standard"]
print(standard_table)




seq1 = Seq("ACGT", IUPAC.unambiguous_dna)
seq2 = Seq("ACGT", IUPAC.ambiguous_dna)
str(seq1) == str(seq2)
str(seq1) == str(seq1)
