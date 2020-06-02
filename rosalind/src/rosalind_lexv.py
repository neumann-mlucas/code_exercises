from string import ascii_lowercase
from itertools import chain, product


def lexv(data):
    seq, n = data[0].split(" "), int(data[1])

    make_order = lambda x: "".join(ascii_lowercase[seq.index(i)] for i in x)
    p = sorted(map(lambda x: "".join(x), permute(seq, n)), key=make_order)

    return "\n".join(p)


def permute(seq, n):
    return flatten(product(seq, repeat=i) for i in range(1, n + 1))


def flatten(list_of_lists):
    return chain.from_iterable(list_of_lists)


DATA_FILE = "dat/rosalind_lexv.txt"

SAMPLE_DATA = """D N A
3"""
SAMPLE_OUTPUT = """
D
DD
DDD
DDN
DDA
DN
DND
DNN
DNA
DA
DAD
DAN
DAA
N
ND
NDD
NDN
NDA
NN
NND
NNN
NNA
NA
NAD
NAN
NAA
A
AD
ADD
ADN
ADA
AN
AND
ANN
ANA
AA
AAD
AAN
AAA"""

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.split("\n")
    print(lexv(SAMPLE_DATA))
    assert lexv(SAMPLE_DATA) == SAMPLE_OUTPUT.lstrip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(lexv(data))
