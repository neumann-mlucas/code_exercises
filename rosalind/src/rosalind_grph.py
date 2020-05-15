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


def gen_graph(data):
    seqs = list(gen_seqs(data))
    nodes = ""
    for (id_seq, seq) in seqs:
        edge = seq[-3:]
        adjacents = [id_s for (id_s, s) in seqs if s[:3] == edge and id_s != id_seq]
        for adjacent in adjacents:
            nodes += id_seq[1:] + " " + adjacent[1:] + "\n"
    return nodes


DATA_FILE = "dat/rosalind_grph.txt"

SAMPLE_DATA = """
>Rosalind_0498
AAATAAA
>Rosalind_2391
AAATTTT
>Rosalind_2323
TTTTCCC
>Rosalind_0442
AAATCCC
>Rosalind_5013
GGGTGGG"""
SAMPLE_OUTPUT = """
Rosalind_0498 Rosalind_2391
Rosalind_0498 Rosalind_0442
Rosalind_2391 Rosalind_2323"""

# Read data
with open(DATA_FILE, "r") as f:
    data = [l.strip() for l in f.readlines()]

# Assert sample
SAMPLE_DATA = SAMPLE_DATA.split()
assert gen_graph(SAMPLE_DATA).rstrip() == SAMPLE_OUTPUT.lstrip()

# # Produce output
print(gen_graph(data))
