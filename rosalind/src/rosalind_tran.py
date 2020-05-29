from itertools import chain, tee


def tran(data):
    # Discard identifier
    _, seqs = zip(*gen_seqs(data))
    # Eliminate / ignore transitions mutation cases
    just_transversions = lambda x: x.replace("A", "G").replace("C", "T")
    # total = transversions + transitions
    total = hamm(seqs)
    transversions = hamm(map(just_transversions, seqs))
    transitions = total - transversions
    return f"{transitions / transversions:.11f}"


def hamm(seqs):
    distance = sum(0 if a == b else 1 for (a, b) in zip(*seqs))
    return distance


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


DATA_FILE = "dat/rosalind_tran.txt"

SAMPLE_DATA = """
>Rosalind_0209
GCAACGCACAACGAAAACCCTTAGGGACTGGATTATTTCGTGATCGTTGTAGTTATTGGA
AGTACGGGCATCAACCCAGTT
>Rosalind_2200
TTATCTGACAAAGAAAGCCGTCAACGGCTGGATAATTTCGCGATCGTGCTGGTTACTGGC
GGTACGAGTGTTCCTTTGGGT"""
SAMPLE_OUTPUT = "1.21428571429"

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split()
    assert tran(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(tran(data))
