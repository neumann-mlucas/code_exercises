from itertools import tee, chain
from collections import Counter


def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)


def gen_seqs(data):
    id_lines = (n for (n, l) in enumerate(data) if l.startswith(">"))
    # add last line to iter
    id_lines = chain(id_lines, (len(data),))
    for i, j in pairwise(id_lines):
        id_seq, seq = data[i], "".join(data[i + 1 : j])
        yield id_seq, seq


def calc_content(seq):
    count = Counter(seq)
    return 100 * (count["G"] + count["C"]) / len(seq)


def max_content(data):
    content, id_seq = max((calc_content(seq), id_seq) for id_seq, seq in gen_seqs(data))
    return f"\n{id_seq[1:]}\n{content:.6f}"


DATA_FILE = "dat/rosalind_gc.txt"

SAMPLE_DATA = """
>Rosalind_6404
CCTGCGGAAGATCGGCACTAGAATAGCCAGAACCGTTTCTCTGAGGCTTCCGGCCTTCCC
TCCCACTAATAATTCTGAGG
>Rosalind_5959
CCATCGGTAGCGCATCCTTAGTCCAATTAAGTCCCTATCCAGGCGCTCCGCCGAAGGTCT
ATATCCATTTGTCAGCAGACACGC
>Rosalind_0808
CCACCCTCGTGGTATGGCTAGGCATTCAGGAACCGGAGAACGCTTCAGACCAGCCCGGAC
TGGGAACCTGCGGGCAGTAGGTGGAAT"""
SAMPLE_OUTPUT = """
Rosalind_0808
60.919540"""

# Read data
with open(DATA_FILE, "r") as f:
    data = [l.strip() for l in f.readlines()]

# Assert sample
SAMPLE_DATA = SAMPLE_DATA.split()
assert max_content(SAMPLE_DATA) == SAMPLE_OUTPUT

# Produce output
print(max_content(data))
