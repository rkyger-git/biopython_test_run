# -*- coding: utf-8 -*-
"""
Created on Mon Sep  2 09:45:10 2019

@author: Ryan
"""


import Bio
print(Bio.__version__)


from Bio.Seq import Seq 

my_seq = Seq("AGTACACTGGT")

print(my_seq)

print(len(my_seq))

print(my_seq[0])
print(my_seq[1])

print(my_seq[0:3])

my_seq.count("G")
my_seq.count("C")
my_seq.count("A")
my_seq.count("T")

my_seq.lower()
my_seq.upper()
my_seq.complement()
my_seq.reverse_complement()
my_seq.transcribe()
my_seq.translate()


from Bio.SeqUtils import GC

#get GC content
print(GC(my_seq))

#get AT content
print(100-GC(my_seq))

#create mutable sequence
mutable_seq = my_seq.tomutable()
print(mutable_seq)

mutable_seq[5] = "G"
print(mutable_seq)

#go back to Seq
new_seq = mutable_seq.toseq()
print(new_seq)







   
