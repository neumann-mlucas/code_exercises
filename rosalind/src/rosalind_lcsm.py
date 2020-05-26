from collections import Counter
from itertools import chain, islice, takewhile, tee


def lcsm(data):
    all_seqs = gen_seqs(data)
    # Discard identifier
    _, all_seqs = zip(*all_seqs)
    # Compare smallest sequence to all others
    seq1 = min(all_seqs, key=lambda x: len(x))
    all_subs = (get_all_substrings(seq1, seq2) for seq2 in all_seqs)
    common_subs = set.intersection(*all_subs)
    longest = max(len(sub) for sub in common_subs)
    return [sub for sub in common_subs if len(sub) == longest]


def get_all_substrings(seq1, seq2):
    all_substrings = set()
    matrix = get_identity_matrix(seq1, seq2)
    for idx in get_substring_indexes(matrix):
        sub = get_substring(idx, seq1, seq2)
        # Add substrings of substring
        for i in range(len(sub) - 1):
            all_substrings.add(sub[i:])
    return all_substrings


def get_identity_matrix(seq1, seq2):
    # m columns, n lines
    m, n = len(seq1), len(seq2)
    # Create identity matrix
    matrix = [[int(i == j) for j in seq2] for i in seq1]
    # Add values in diagonals
    for i in range(1, m):
        for j in range(1, n):
            matrix[i][j] = (
                matrix[i][j] + matrix[i - 1][j - 1] if matrix[i][j] == 1 else 0
            )
    return matrix


def get_substring_indexes(matrix):
    # m columns, n lines
    m, n = len(matrix), len(matrix[0])
    flat_idx = ((i, j) for i in range(m) for j in range(n))
    flat_mat = (n for col in matrix for n in col)
    # return just the substrings with length > 1
    return filter(lambda x: x[0] > 1, zip(flat_mat, flat_idx))


def get_substring(idx, seq1, seq2):
    # m columns, n lines
    length, (m, n) = idx
    # Generates substring diagonal indexes
    indexes = ((m - i, n - i) for i in range(length))
    idx_seq1, idx_seq2 = zip(*indexes)
    # Map positions to sequences
    substring1 = "".join(map(lambda x: seq1[x], idx_seq1[::-1]))
    substring2 = "".join(map(lambda x: seq2[x], idx_seq2[::-1]))
    # Check if seq1 map equals seq2 map
    assert substring1 == substring2
    # Return common substring
    return substring1


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


DATA_FILE = "dat/rosalind_lcsm.txt"

SAMPLE_DATA = """
>Rosalind_1
GATTACA
>Rosalind_2
TAGACCA
>Rosalind_3
ATACA"""
SAMPLE_OUTPUT = "AC"

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split()
    assert SAMPLE_OUTPUT in lcsm(SAMPLE_DATA)
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(*lcsm(data))
