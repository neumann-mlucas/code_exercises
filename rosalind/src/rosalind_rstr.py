from functools import reduce


def format_rstr(func):
    def wrapper(*args, **kwargs):
        output = func(*args, **kwargs)
        return str(round(output, 3))

    return wrapper


@format_rstr
def rstr(data):
    (n, cg), seq = map(float, data[0].split(" ")), data[1]
    p_of_not_equal = 1 - calc_prob(seq, get_cg_dict(cg))
    p_of_none_equal = p_of_not_equal ** n
    return 1 - p_of_none_equal


def calc_prob(seq, d_cg):
    return reduce(lambda x, y: x * y, map(lambda x: d_cg[x], seq))


def get_cg_dict(cg):
    at, cg = (
        (1 - cg) / 2,
        cg / 2,
    )
    return {"A": at, "T": at, "C": cg, "G": cg}


DATA_FILE = "dat/rosalind_rstr.txt"

SAMPLE_DATA = """
90000 0.6
ATAGCCGA"""
SAMPLE_OUTPUT = "0.689"

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.lstrip().split("\n")
    assert rstr(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(rstr(data))
