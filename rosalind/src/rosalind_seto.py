def format_seto(func):
    def wrapper(*args, **kwargs):
        output = func(*args, **kwargs)
        return "\n".join(s.__repr__() for s in output)

    return wrapper


@format_seto
def seto(data):
    n, sA, sB = data

    sA = set(int(i) for i in sA[1:-1].split(","))
    sB = set(int(i) for i in sB[1:-1].split(","))
    sC = set(range(1, int(n) + 1))

    return (
        sA.union(sB),
        sA.intersection(sB),
        sA.difference(sB),
        sB.difference(sA),
        sC.difference(sA),
        sC.difference(sB),
    )


DATA_FILE = "dat/rosalind_seto.txt"

SAMPLE_DATA = """
10
{1, 2, 3, 4, 5}
{2, 8, 5, 10}"""
SAMPLE_OUTPUT = """
{1, 2, 3, 4, 5, 8, 10}
{2, 5}
{1, 3, 4}
{8, 10}
{6, 7, 8, 9, 10}
{1, 3, 4, 6, 7, 9}"""

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = SAMPLE_DATA.lstrip().split("\n")
    assert seto(SAMPLE_DATA) == SAMPLE_OUTPUT.lstrip()
    # Read data
    with open(DATA_FILE, "r") as f:
        data = [l.strip() for l in f.readlines()]
    # Produce output
    print(seto(data))
