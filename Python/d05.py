import re
from itertools import compress

with open("data/d05.txt") as f:
    input = f.read().split("\n")

def parse_stack(input):
    box_pos = input[:input.index("")-1]
    n_stack = [re.findall(r'\d+', m) for m in input[input.index("")-1]]
    n_stack = list(compress(n_stack, [len(e) > 0 for e in n_stack]))
    n_stack = int(n_stack[len(n_stack)-1][0])    
    stacks = [[] for _ in range(n_stack)]
    typ_idx = [i-1 for i in range(n_stack * 4) if (i-2) % 4 == 0]

    for e in box_pos:
        for ii in range(len(typ_idx)):
            content = e[typ_idx[ii]]
            if content != " ":
                stacks[ii].insert(0, content)
    
    return stacks

def parse_mvs(input):
    mv = input[input.index("")+1:]    
    mv = [re.findall(r'\d+', m) for m in mv]
    return mv

def mk_mv(start, move, frm, to, crane):
    l = len(start[int(frm)-1])
    x = start[int(frm)-1][(l-int(move)):(l)]
    if crane == 9000:
        x.reverse()
        start[int(to)-1].extend(x)
    else:
        start[int(to)-1].extend(x)
    del start[int(frm)-1][(l-int(move)):(l)]
    return start

def solve(input, crane):
    stacks = parse_stack(input)
    mv = parse_mvs(input)

    for m in mv:
        stacks = mk_mv(stacks, m[0], m[1], m[2], crane)
        print(stacks)

    return ''.join([l[len(l)-1] for l in stacks])

# Part 1 Answer
print(solve(input, 9000))

# Part 2 Answer
print(solve(input, 9001))
