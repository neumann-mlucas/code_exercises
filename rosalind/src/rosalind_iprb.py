from itertools import permutations, tee


def iprb(numbers):
    possible_pairs = list(permutations(gen_population(numbers), 2))
    prob_pair = len(possible_pairs) ** -1
    # Sort & join to match keys in dict
    sorted_pairs = ("".join(sorted(p)) for p in possible_pairs)
    childrem_is_dominant = sum(prob_pair * dominant_prob[k] for k in sorted_pairs)
    # return formated string w/ probability
    return f"{childrem_is_dominant:.5f}"


def gen_population(numbers):
    return "".join(letter * n for (letter, n) in zip("kmn", numbers))


DATA_FILE = "dat/rosalind_iprb.txt"

SAMPLE_DATA = "2 2 2"
SAMPLE_OUTPUT = "0.78333"

# 'k' is homozygous dominant, 'm' heterozygous and 'n' homozygous recessive
dominant_prob = {"kk": 1.0, "km": 1.0, "kn": 1.0, "mm": 0.75, "mn": 0.5, "nn": 0.0}

if __name__ == "__main__":
    # Assert sample
    SAMPLE_DATA = map(int, SAMPLE_DATA.split(" "))
    assert iprb(SAMPLE_DATA) == SAMPLE_OUTPUT
    # Read data
    with open(DATA_FILE, "r") as f:
        data = map(int, f.readline().strip().split(" "))
    # Produce output
    print(iprb(data))
