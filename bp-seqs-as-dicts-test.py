# -*- coding: utf-8 -*-
"""
Created on Tue Sep  3 16:15:28 2019

@author: Ryan
"""

# Sequence files as Dictionaries – In memory

#GenBank
from Bio import SeqIO

orchid_dict = SeqIO.to_dict(SeqIO.parse("ls_orchid.gbk", "genbank"))

len(orchid_dict)

list(orchid_dict.keys())

list(orchid_dict.values())


seq_record = orchid_dict["Z78475.1"]

print(seq_record.description)

print(repr(seq_record.seq))


#fasta
from Bio import SeqIO

orchid_dict = SeqIO.to_dict(SeqIO.parse("ls_orchid.fasta", "fasta"))

print(orchid_dict.keys())

def get_accession(record):
    """"Given a SeqRecord, return the accession number as a string.

    e.g. "gi|2765613|emb|Z78488.1|PTZ78488" -> "Z78488.1"
    """
    parts = record.id.split("|")
    assert len(parts) == 5 and parts[0] == "gi" and parts[2] == "emb"
    return parts[3]

from Bio import SeqIO

orchid_dict = SeqIO.to_dict(SeqIO.parse("ls_orchid.fasta", "fasta"), key_function=get_accession)

print(orchid_dict.keys())

#Sequence files as Dictionaries – Indexed files -Use for large files

from Bio import SeqIO
orchid_dict = SeqIO.index("ls_orchid.gbk", "genbank")
len(orchid_dict)

print(list(orchid_dict.keys()))


from Bio import SeqIO
orchid_dict = SeqIO.index("ls_orchid.fasta", "fasta")
len(orchid_dict)

print(list(orchid_dict.keys()))

def get_acc(identifier):
    """"Given a SeqRecord identifier string, return the accession number as a string.

    e.g. "gi|2765613|emb|Z78488.1|PTZ78488" -> "Z78488.1"
    """
    parts = identifier.split("|")
    assert len(parts) == 5 and parts[0] == "gi" and parts[2] == "emb"
    return parts[3]

from Bio import SeqIO
orchid_dict = SeqIO.index("ls_orchid.fasta", "fasta", key_function=get_acc)
print(list(orchid_dict.keys()))

