from itertools import permutations


def format_perm(func):
    def wrapper(*args, **kwargs):
        n, ps = func(*args, **kwargs)
        ps = "\n".join(" ".join(map(str, p)) for p in ps)
        return f"{n}\n{ps}"

    return wrapper


@format_perm
def perm(n):
    all_perm = list(permutations(range(1, int(n) + 1)))
    return len(all_perm), sorted(all_perm)


DATA_FILE = "dat/rosalind_perm.txt"

SAMPLE_DATA = "3"
SAMPLE_OUTPUT = """
6
1 2 3
1 3 2
2 1 3
2 3 1
3 1 2
3 2 1"""

mass_mapping = {
    "A": 71.03711,
    "C": 103.00919,
    "D": 115.02694,
    "E": 129.04259,
    "F": 147.06841,
    "G": 57.02146,
    "H": 137.05891,
    "I": 113.08406,
    "K": 128.09496,
    "L": 113.08406,
    "M": 131.04049,
    "N": 114.04293,
    "P": 97.05276,
    "Q": 128.05858,
    "R": 156.10111,
    "S": 87.03203,
    "T": 101.04768,
    "V": 99.06841,
    "W": 186.07931,
    "Y": 163.06333,
}

if __name__ == "__main__":
    # Assert sample
    assert perm(SAMPLE_DATA) == SAMPLE_OUTPUT.lstrip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = f.readline().strip()
    # Produce output
    print(perm(data))
