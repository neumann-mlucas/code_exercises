from collections import Counter
from itertools import chain, product, tee


def format_corr(func):
    def wrapper(*args, **kwargs):
        output = func(*args, **kwargs)
        formated = map(lambda x: f"\n{x[0]}->{x[1]}", output)
        return "".join(formated)

    return wrapper


@format_corr
def corr(data):
    seqs = [s[1] for s in gen_seqs(data)]
    d_seqs = Counter(seqs)

    good_reads = (k for (k, v) in d_seqs.items() if v > 1 or rcomp(k) in d_seqs)
    bad_reads = (k for (k, v) in d_seqs.items() if v == 1 and rcomp(k) not in d_seqs)

    possible_matchs = set(chain(*map(lambda x: (x, rcomp(x)), good_reads)))
    return [s for s in product(bad_reads, possible_matchs) if h_dist(s) == 1]


def h_dist(seqs):
    return sum(a != b for (a, b) in zip(*seqs))


def rcomp(seq):
    return seq.translate(revc_mapping)[::-1]


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


revc_mapping = {
    ord("A"): ord("T"),
    ord("C"): ord("G"),
    ord("G"): ord("C"),
    ord("T"): ord("A"),
}

DATA_FILE = "dat/rosalind_corr.txt"

SAMPLE_DATA = """
>Rosalind_52
TCATC
>Rosalind_44
TTCAT
>Rosalind_68
TCATC
>Rosalind_28
TGAAA
>Rosalind_95
GAGGA
>Rosalind_66
TTTCA
>Rosalind_33
ATCAA
>Rosalind_21
TTGAT
>Rosalind_18
TTTCC"""
SAMPLE_OUTPUT = """
TTCAT->TTGAT
GAGGA->GATGA
TTTCC->TTTCA"""


if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.lstrip().split("\n")

    print(corr(SAMPLE_DATA))

    assert corr(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(corr(data))
