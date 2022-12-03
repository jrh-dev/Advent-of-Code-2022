with open("data/d02.txt") as f:
    input = [s.replace(" ", "") for s in f.read().split("\n")]

opt_1 = {
    "AX": 4, #  rock rock
    "AY": 8, #  rock paper
    "AZ": 3, #  rock scissors
    "BX": 1, #  paper rock
    "BY": 5, #  paper paper
    "BZ": 9, #  paper scissors
    "CX": 7, #  scissors rock
    "CY": 2, #  scissors paper
    "CZ": 6  #  scissors scissors
}

opt_2 = {
    "AX": 3, #  rock scissors
    "AY": 4, #  rock rock
    "AZ": 8, #  rock paper
    "BX": 1, #  paper rock
    "BY": 5, #  paper paper
    "BZ": 9, #  paper scissors
    "CX": 2, #  scissors paper
    "CY": 6, #  scissors scissors
    "CZ": 7  #  scissors rock
}

def solve(input:list[str], dict:dict) -> int:
    '''
    Solves day 2 of AOC 2022
    Parameters: input -- list[str], dict -- dict
    Returns: value -- int
    '''
    return sum([dict[i] for i in input])

# Part 1 Answer
print(solve(input, opt_1))

# Part 2 Answer
print(solve(input, opt_2))