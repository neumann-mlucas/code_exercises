import re
from itertools import islice, tee


def to_revc(seq):
    complement = seq.translate(complement_map)
    return complement[::-1]


def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)


def translate(seq):
    codons = (seq[i:j] for i, j in pairwise(range(0, len(seq) + 1, 3)))
    aa = "".join(codon_table[c] for c in codons)
    return aa[: aa.find("!")] if "!" in aa else ""


def transcript(seq):
    proteins = set()
    for dna in (seq, to_revc(seq)):
        starts = (aa.start() for aa in re.finditer("ATG", dna))
        proteins.update(set(translate(dna[s:]) for s in starts))
    proteins.discard("")
    return proteins


def prot_to_string(proteins):
    return "\n".join(str(p) for p in proteins if p)


DATA_FILE = "dat/rosalind_orf.txt"

SAMPLE_DATA = """
>Rosalind_99
AGCCATGTAGCTAACTCAGGTTACATGGGGATGACCCCGCGACTTGGATTAGAGTCTCTTTTGGAATAAGCCTGAATGATCCGAGTAGCATCTCAG"""
SAMPLE_OUTPUT = """
MLLGSFRLIPKETLIQVAGSSPCNLS
M
MGMTPRLGLESLLE
MTPRLGLESLLE"""

complement_map = {
    ord("A"): ord("T"),
    ord("C"): ord("G"),
    ord("G"): ord("C"),
    ord("T"): ord("A"),
}

codon_table = {
    "AAA": "K",
    "AAC": "N",
    "AAG": "K",
    "AAT": "N",
    "ACA": "T",
    "ACC": "T",
    "ACG": "T",
    "ACT": "T",
    "AGA": "R",
    "AGC": "S",
    "AGG": "R",
    "AGT": "S",
    "ATA": "I",
    "ATC": "I",
    "ATG": "M",
    "ATT": "I",
    "CAA": "Q",
    "CAC": "H",
    "CAG": "Q",
    "CAT": "H",
    "CCA": "P",
    "CCC": "P",
    "CCG": "P",
    "CCT": "P",
    "CGA": "R",
    "CGC": "R",
    "CGG": "R",
    "CGT": "R",
    "CTA": "L",
    "CTC": "L",
    "CTG": "L",
    "CTT": "L",
    "GAA": "E",
    "GAC": "D",
    "GAG": "E",
    "GAT": "D",
    "GCA": "A",
    "GCC": "A",
    "GCG": "A",
    "GCT": "A",
    "GGA": "G",
    "GGC": "G",
    "GGG": "G",
    "GGT": "G",
    "GTA": "V",
    "GTC": "V",
    "GTG": "V",
    "GTT": "V",
    "TAA": "!",
    "TAC": "Y",
    "TAG": "!",
    "TAT": "Y",
    "TCA": "S",
    "TCC": "S",
    "TCG": "S",
    "TCT": "S",
    "TGA": "!",
    "TGC": "C",
    "TGG": "W",
    "TGT": "C",
    "TTA": "L",
    "TTC": "F",
    "TTG": "L",
    "TTT": "F",
}

# Read data
with open(DATA_FILE, "r") as f:
    id_seq, *seq = [l.strip() for l in f.readlines()]
    seq = "".join(seq)

# Assert sample
_, SAMPLE_DATA = SAMPLE_DATA.split()
assert transcript(SAMPLE_DATA) == set(SAMPLE_OUTPUT.split())

# Produce output
print(prot_to_string(transcript(seq)))
