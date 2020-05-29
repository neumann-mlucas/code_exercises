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

if __name__ == "__main__":
    # Assert sample
    assert perm(SAMPLE_DATA) == SAMPLE_OUTPUT.lstrip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = f.readline().strip()
    # Produce output
    print(perm(data))
