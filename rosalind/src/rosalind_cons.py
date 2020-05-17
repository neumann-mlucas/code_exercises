from collections import ChainMap, Counter
from itertools import chain, tee


def format_cons(func):
    def wrapper(*args, **kwargs):
        output = func(*args, **kwargs)
        return get_consensus(output) + to_string(output)

    return wrapper


@format_cons
def cons(data):
    matrix = (seq for _, seq in gen_seqs(data))
    # Combine Counter and default_dict in case some n.a. not in column
    defalt_dict = {"A": 0, "C": 0, "G": 0, "T": 0}
    columns = (ChainMap(Counter(c), defalt_dict) for c in zip(*matrix))
    # Sort by key and get only the values
    sorted_columns = (map(lambda x: x[1], sorted(c.items())) for c in columns)
    # Return transpose matrix
    return [l for l in zip(*sorted_columns)]


def get_consensus(matrix):
    mapping = ("A", "C", "G", "T")
    # Quick and dirt
    get_idx_max = lambda x: mapping[x.index(max(x))]
    consensus = (get_idx_max(column) for column in zip(*matrix))
    return "".join(consensus)


def to_string(matrix):
    return f"""
A: {' '.join(map(str,matrix[0]))}
C: {' '.join(map(str,matrix[1]))}
G: {' '.join(map(str,matrix[2]))}
T: {' '.join(map(str,matrix[3]))}"""


def gen_seqs(data):
    idx_lines = (n for (n, l) in enumerate(data) if l.startswith(">"))
    # Add last line to iter
    idx_lines = chain(idx_lines, (len(data),))
    for i, j in pairwise(idx_lines):
        id_seq, seq = data[i], "".join(data[i + 1 : j])
        yield id_seq, seq


def pairwise(iterable):
    "s -> (s0,s1), (s1,s2), (s2, s3), ..."
    a, b = tee(iterable)
    next(b, None)
    return zip(a, b)


DATA_FILE = "dat/rosalind_cons.txt"

SAMPLE_DATA = """
>Rosalind_1
ATCCAGCT
>Rosalind_2
GGGCAACT
>Rosalind_3
ATGGATCT
>Rosalind_4
AAGCAACC
>Rosalind_5
TTGGAACT
>Rosalind_6
ATGCCATT
>Rosalind_7
ATGGCACT"""
SAMPLE_OUTPUT = """ATGCAACT
A: 5 1 0 0 5 5 0 0
C: 0 0 1 4 2 0 6 1
G: 1 1 6 3 0 1 0 0
T: 1 5 0 0 0 1 1 6"""

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split()
    assert (cons(SAMPLE_DATA)) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(cons(data))
