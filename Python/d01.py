with open("data/d01.txt") as f:
    input = f.read().split("\n")

def solve(input:list[str], top:int) -> int:
    '''
    Solves day 1 of AOC 2022
    Parameters: input -- list[str], top -- int
    Returns: value -- int
    '''
    input = [int(x) if x not in '' else None for x in input]
    splits = [i for i, e in enumerate(input) if e == None]
    splits.append(len(input))
    res = []
    start = 0

    for ii in range(len(splits)):
        res.append(sum(input[start:splits[ii]]))
        start = splits[ii] + 1  

    res.sort(reverse=True)

    return sum(res[0:top])

# Part 1 Answer
print(solve(input, 1))

# Part 2 Answer
print(solve(input, 3))