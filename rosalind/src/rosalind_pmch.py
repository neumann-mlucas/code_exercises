from math import factorial
from functools import reduce
from collections import Counter


def pmch(seq):
    c = Counter(seq)
    matchs = factorial(c["A"]) * factorial(c["C"])
    return str(matchs)


DATA_FILE = "dat/rosalind_pmch.txt"

SAMPLE_DATA = """
>Rosalind_23
AGCUAGUCAU"""
SAMPLE_OUTPUT = "12"

if __name__ == "__main__":
    # Assert sample
    _, SAMPLE_DATA = SAMPLE_DATA.split()
    assert pmch(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = "".join(l.strip() for l in f.readlines() if not l.startswith(">"))
    # Produce output
    print(pmch(data))
