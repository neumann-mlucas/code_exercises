from itertools import chain, tee


def long(data):
    sseq, *seqs = [s[1] for s in gen_seqs(data)]

    while seqs:
        seqs.sort(key=lambda x: len(overlap(sseq, x)))
        sseq = join_seqs(sseq, seqs.pop())

    return sseq


def better_long(data):
    # Greedy algorithm, always join the best pair

    seqs = [s[1] for s in gen_seqs(data)]

    while len(seqs) > 1:

        i, j, a, b = max(
            [
                (i, j, a, b)
                for (i, a) in enumerate(seqs)
                for (j, b) in enumerate(seqs)
                if i < j
            ],
            key=lambda x: len(overlap(x[2], x[3])),
        )

        seqs = seqs[:i] + seqs[i + 1 : j] + seqs[j + 1 :] + [join_seqs(a, b)]

    return seqs[0]


def join_seqs(a, b):

    if b in a:
        return a

    head, _, tail = b.partition(overlap(a, b))

    return max(a + tail, head + a, key=len)


def overlap(a, b):

    start = max((b[i:] for i in range(len(b) + 1) if a.startswith(b[i:])), key=len)
    end = max((b[:i] for i in range(len(b)) if a.endswith(b[:i])), key=len)

    return max(start, end, key=len)


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


DATA_FILE = "dat/rosalind_long.txt"

SAMPLE_DATA = """
>Rosalind_56
ATTAGACCTG
>Rosalind_57
CCTGCCGGAA
>Rosalind_58
AGACCTGCCG
>Rosalind_59
GCCGGAATAC"""
SAMPLE_OUTPUT = "ATTAGACCTGCCGGAATAC"

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split()
    assert long(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(long(data))
