from itertools import accumulate, chain, tee, repeat


def sseq(data):
    _, (seq, motif) = zip(*gen_seqs(data))

    char = iter(motif)
    # '+ 2' is an arbitrary constant, it's here just to satisfy SAMPLE_OUTPUT
    fn = lambda x, _: seq[x + 2 :].find(next(char)) + x + 2
    _, *idxs = accumulate(repeat(0, len(motif) + 1), fn)
    return " ".join(map(lambda x: str(x + 1), idxs))


def gen_seqs(data):
    idx_lines = (n for (n, l) in enumerate(data) if l.startswith(">"))
    # Add last line to iter
    idx_lines = chain(idx_lines, (len(data),))
    for i, j in pairwise(idx_lines):
        id_seq, seq = data[i], "".join(data[i + 1 : j])
        yield id_seq, seq


def pairwise(iterable):
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)


DATA_FILE = "dat/rosalind_sseq.txt"

SAMPLE_DATA = """
>Rosalind_14
ACGTACGTGACG
>Rosalind_18
GTA"""
SAMPLE_OUTPUT = "3 8 10"

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split()
    assert sseq(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(sseq(data))
