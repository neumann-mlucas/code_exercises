from functools import reduce
from math import log


def format_prob(func):
    def wrapper(*args, **kwargs):
        output = func(*args, **kwargs)
        return " ".join(map(lambda x: f"{x:.3f}", output))

    return wrapper


@format_prob
def prob(data):
    seq, cgs = data[0], map(float, data[1].split(" "))
    d_cgs = map(get_cg_dict, cgs)
    probs = (calc_prob(seq, d_cg) for d_cg in d_cgs)
    return probs


def calc_prob(seq, d_cg):
    prob = reduce(lambda x, y: x * y, map(lambda x: d_cg[x], seq))
    return log(prob, 10)


def get_cg_dict(cg):
    at, cg = (
        (1 - cg) / 2,
        cg / 2,
    )
    return {"A": at, "T": at, "C": cg, "G": cg}


DATA_FILE = "dat/rosalind_prob.txt"

SAMPLE_DATA = """
ACGATACAA
0.129 0.287 0.423 0.476 0.641 0.742 0.783"""
SAMPLE_OUTPUT = """-5.737 -5.217 -5.263 -5.360 -5.958 -6.628 -7.009"""

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.lstrip().split("\n")
    assert prob(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(prob(data))
