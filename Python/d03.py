import string

up_let = string.ascii_uppercase
low_let = string.ascii_lowercase

with open("data/d03.txt") as f:
    input = f.read().split("\n")


lhs = [s[0:len(s)//2] for s in input]

rhs = [s[len(s)//2:len(s)] for s in input]

it = 0

for ii in range(len(input)):
    for jj in range(len(lhs[ii])):
        if rhs[ii].find(lhs[ii][jj]) > -1:
            if up_let.find(lhs[ii][jj]) > -1:
                it += up_let.find(lhs[ii][jj]) + 27
                break
            else:
                it += low_let.find(lhs[ii][jj]) + 1
                break
        else:
            continue

print(it)