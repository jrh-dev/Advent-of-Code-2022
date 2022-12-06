with open("data/d06.txt") as f:
    input = f.read().split("\n")

def solve(s, l):
    for ii in range(len(s[0])-(l-1)):
        if len(set(s[0][ii:(ii+l)])) == l:
            x = ii + l
            break
    return x

# Part 1 Answer
solve(input,4)

# Part 2 Answer
solve(input,14)