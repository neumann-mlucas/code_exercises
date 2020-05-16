def format_prtm(func):
    def wrapper(*args, **kwargs):
        output = str(round(func(*args, **kwargs), 3))
        return output

    return wrapper


@format_prtm
def prtm(seq):
    return sum(mass_mapping[aa] for aa in seq)


DATA_FILE = "dat/rosalind_prtm.txt"
SAMPLE_DATA = "SKADYEK"
SAMPLE_OUTPUT = "821.392"

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
    assert prtm(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        seq = f.readline().strip()
    # Produce output
    print(prtm(seq))
