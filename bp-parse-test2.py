# -*- coding: utf-8 -*-
"""
Created on Mon Sep  2 10:50:36 2019

@author: Ryan
"""

from Bio import SeqIO
record = SeqIO.read("NC_005816.gb", "genbank")
record

help(SeqIO)


from Bio import SeqIO
records = list(SeqIO.parse("ls_orchid.gbk", "genbank"))

print("Found %i records" % len(records))

print("The last record")
last_record = records[-1] #using Python's list tricks
print(last_record.id)
print(repr(last_record.seq))
print(len(last_record))

print("The first record")
first_record = records[0] #remember, Python counts from zero
print(first_record.id)
print(repr(first_record.seq))
print(len(first_record))


from Bio import SeqIO
record_iterator = SeqIO.parse("ls_orchid.gbk", "genbank")
first_record = next(record_iterator)
print(first_record)
print(first_record.annotations["organism"])


from Bio import SeqIO
all_species = [seq_record.annotations["organism"] for seq_record in \
               SeqIO.parse("ls_orchid.gbk", "genbank")]
print(all_species)

import gzip
from Bio import SeqIO
with gzip.open("ls_orchid.gbk.gz", "rt") as handle:
    print(sum(len(r) for r in SeqIO.parse(handle, "gb")))