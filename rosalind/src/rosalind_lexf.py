from itertools import permutations


def lexf(data):
    chars, n = data
    # Need to generate sequences with char repetition (e.g. AAx, AAA)
    chars = chars.replace(" ", "") * int(n)
    p = set(permutations(chars, int(n)))
    return "\n".join("".join(s) for s in sorted(p))


DATA_FILE = "dat/rosalind_lexf.txt"

SAMPLE_DATA = """A C G T
2"""
SAMPLE_OUTPUT = """ 
AA
AC
AG
AT
CA
CC
CG
CT
GA
GC
GG
GT
TA
TC
TG
TT"""

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split("\n")
    assert lexf(SAMPLE_DATA) == SAMPLE_OUTPUT.lstrip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(lexf(data))
