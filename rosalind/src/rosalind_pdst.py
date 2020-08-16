from itertools import chain, tee


def format_pdst(func):
    def wrapper(*args, **kwargs):
        output = func(*args, **kwargs)
        f_value = lambda x: f"{x:.05f}"
        f_line = lambda x: " ".join(map(f_value, x))
        return "\n".join(map(f_line, output))

    return wrapper


@format_pdst
def pdst(data):
    seqs = [s[1] for s in gen_seqs(data)]
    return [[p_distance(i, j) for i in seqs] for j in seqs]


def p_distance(s1, s2):
    return sum(a != b for (a, b) in zip(s1, s2)) / len(s1)


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


DATA_FILE = "dat/rosalind_pdst.txt"

SAMPLE_DATA = """
>Rosalind_9499
TTTCCATTTA
>Rosalind_0942
GATTCATTTC
>Rosalind_6568
TTTCCATTTT
>Rosalind_1833
GTTCCATTTA"""
SAMPLE_OUTPUT = """
0.00000 0.40000 0.10000 0.10000
0.40000 0.00000 0.40000 0.30000
0.10000 0.40000 0.00000 0.20000
0.10000 0.30000 0.20000 0.00000"""

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split()
    assert pdst(SAMPLE_DATA) == SAMPLE_OUTPUT.lstrip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(pdst(data))
