import string

up_let = string.ascii_uppercase
low_let = string.ascii_lowercase

with open("data/d03.txt") as f:
    input = f.read().split("\n")

def solve_p1(data:list[str], up:list[str], low:list[str]) -> int:
    '''
    Solves day 3 part 1 of AOC 2022
    Parameters: data -- list[str], up -- list[str], low -- list[str]
    Returns: value -- int
    '''
    lhs = [s[0:len(s)//2] for s in data]
    rhs = [s[len(s)//2:len(s)] for s in data]

    it = 0

    for ii in range(len(data)):
        for jj in range(len(lhs[ii])):
            if rhs[ii].find(lhs[ii][jj]) > -1:
                if up.find(lhs[ii][jj]) > -1:
                    it += up.find(lhs[ii][jj]) + 27
                    break
                else:
                    it += low.find(lhs[ii][jj]) + 1
                    break
            else:
                continue

    return it

def solve_p2(data, up:list[str], low:list[str]) -> int:
    '''
    Solves day 3 part 2 of AOC 2022
    Parameters: data -- list[str], up -- list[str], low -- list[str]
    Returns: value -- int
    '''
    it = 0

    for ii in range(len(input)):
        if (ii+1) % 3 != 0:
            continue
        else:
            for jj in input[ii]:
                if (input[ii-1].find(jj) > -1) and (input[ii-2].find(jj) > -1):
                    if up.find(jj) > -1:
                        it += up.find(jj) + 27
                        break
                    else:
                        it += low.find(jj) + 1
                        break

    return it

# Part 1 Answer
print(solve_p1(input, up_let, low_let))

# Part 2 Answer
print(solve_p2(input, up_let, low_let))
