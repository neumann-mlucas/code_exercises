from functools import reduce


def format_eval(func):
    def wrapper(*args, **kwargs):
        output = func(*args, **kwargs)
        return " ".join(map(lambda x: f"{x:.3f}", output))

    return wrapper


@format_eval
def eval(data):
    l_seq, sub, cgs = int(data[0]), data[1], map(float, data[2].split(" "))
    probs = (calc_prob(l_seq, sub, d_cg) for d_cg in map(get_cg_dict, cgs))
    return probs


def calc_prob(l_seq, sub, d_cg):
    p_sub = reduce(lambda x, y: x * y, map(lambda x: d_cg[x], sub))
    return p_sub * (l_seq + 1 - len(sub))


def get_cg_dict(cg):
    at, cg = (
        (1 - cg) / 2,
        cg / 2,
    )
    return {"A": at, "T": at, "C": cg, "G": cg}


DATA_FILE = "dat/rosalind_eval.txt"

SAMPLE_DATA = """
10
AG
0.25 0.5 0.75"""
SAMPLE_OUTPUT = "0.422 0.562 0.422"

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.lstrip().split("\n")
    assert eval(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(eval(data))
