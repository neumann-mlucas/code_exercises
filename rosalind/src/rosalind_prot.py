from itertools import tee


def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)


def translate(seq):
    codons = (seq[i:j] for i, j in pairwise(range(0, len(seq) + 1, 3)))
    aa_seq = "".join(codon_table[c] for c in codons)
    # Split sequence at a stop codon ('!')
    return aa_seq[: aa_seq.find("!")]


DATA_FILE = "dat/rosalind_prot.txt"

SAMPLE_DATA = "AUGGCCAUGGCGCCCAGAACUGAGAUCAAUAGUACCCGUAUUAACGGGUGA"
SAMPLE_OUTPUT = "MAMAPRTEINSTRING"

codon_table = {
    "AAA": "K",
    "AAC": "N",
    "AAG": "K",
    "AAU": "N",
    "ACA": "T",
    "ACC": "T",
    "ACG": "T",
    "ACU": "T",
    "AGA": "R",
    "AGC": "S",
    "AGG": "R",
    "AGU": "S",
    "AUA": "I",
    "AUC": "I",
    "AUG": "M",
    "AUU": "I",
    "CAA": "Q",
    "CAC": "H",
    "CAG": "Q",
    "CAU": "H",
    "CCA": "P",
    "CCC": "P",
    "CCG": "P",
    "CCU": "P",
    "CGA": "R",
    "CGC": "R",
    "CGG": "R",
    "CGU": "R",
    "CUA": "L",
    "CUC": "L",
    "CUG": "L",
    "CUU": "L",
    "GAA": "E",
    "GAC": "D",
    "GAG": "E",
    "GAU": "D",
    "GCA": "A",
    "GCC": "A",
    "GCG": "A",
    "GCU": "A",
    "GGA": "G",
    "GGC": "G",
    "GGG": "G",
    "GGU": "G",
    "GUA": "V",
    "GUC": "V",
    "GUG": "V",
    "GUU": "V",
    "UAA": "!",
    "UAC": "Y",
    "UAG": "!",
    "UAU": "Y",
    "UCA": "S",
    "UCC": "S",
    "UCG": "S",
    "UCU": "S",
    "UGA": "!",
    "UGC": "C",
    "UGG": "W",
    "UGU": "C",
    "UUA": "L",
    "UUC": "F",
    "UUG": "L",
    "UUU": "F",
}

# Read data
with open(DATA_FILE, "r") as f:
    seq = f.readline().strip()

# Assert sample
assert translate(SAMPLE_DATA) == SAMPLE_OUTPUT

# Produce output
print(translate(seq))
