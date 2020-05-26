from itertools import chain, tee


def splc(data):
    # Discard identifier
    _, seqs = zip(*gen_seqs(data))
    exon, *introns = seqs
    for intron in introns:
        exon = del_intron(exon, intron)
    return prot(exon)


def del_intron(exon, intron):
    return exon.replace(intron, "")


def prot(seq):
    codons = (seq[i:j] for i, j in pairwise(range(0, len(seq) + 1, 3)))
    aa_seq = "".join(codon_table[c] for c in codons)
    # Split sequence at a stop codon ('!')
    return aa_seq[: aa_seq.find("!")]


def gen_seqs(data):
    idx_lines = (n for (n, l) in enumerate(data) if l.startswith(">"))
    # add last line to iter
    idx_lines = chain(idx_lines, (len(data),))
    for i, j in pairwise(idx_lines):
        id_seq, seq = data[i], "".join(data[i + 1 : j])
        yield id_seq, seq


def pairwise(iterable):
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)


DATA_FILE = "dat/rosalind_splc.txt"

SAMPLE_DATA = """
>Rosalind_10
ATGGTCTACATAGCTGACAAACAGCACGTAGCAATCGGTCGAATCTCGAGAGGCATATGGTCACATGATCGGTCGAGCGTGTTTCAAAGTTTGCGCCTAG
>Rosalind_12
ATCGGTCGAA
>Rosalind_15
ATCGGTCGAGCGTGT"""
SAMPLE_OUTPUT = "MVYIADKQHVASREAYGHMFKVCA"

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

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split()
    assert splc(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(splc(data))
