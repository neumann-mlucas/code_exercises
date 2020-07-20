from itertools import permutations


def format_sign(func):
    def wrapper(*args, **kwargs):
        output = list(func(*args, **kwargs))
        text = "\n".join(sorted(" ".join(map(str, x)) for x in output))
        return f"{len(output)}\n{text}"

    return wrapper


@format_sign
def sign(n):
    ns = [i for i in range(-n, n + 1) if i != 0]
    check = lambda x: len(set(map(abs, x))) == n
    return filter(check, permutations(ns, r=n))


DATA_FILE = "dat/rosalind_sign.txt"

SAMPLE_DATA = "2"
SAMPLE_OUTPUT = """
8
-1 -2
-1 2
-2 -1
-2 1
1 -2
1 2
2 -1
2 1"""

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = int(SAMPLE_DATA)
    assert sign(SAMPLE_DATA).strip() == SAMPLE_OUTPUT.strip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = int(f.read().strip())
    # Produce output
    print(sign(data))
