with open("data/d07.txt") as f:
    input = f.read().split("\n")

paths = []
size = []
wd = []

for ii in range(len(input)):
    x = input[ii]
    if x[0:7] == "$ cd ..":
        wd = wd[0:len(wd)-1]
    elif x[0:4] == "$ cd":
        wd.append(x[5:])
    elif x[0].isdigit():
        for l in range(len(wd)):
            paths.append("".join(wd[0:l+1]))
            size.append(x.split(" ")[0])            

uni_path = list(set(paths))
size_by_path = {}

for p in uni_path:
    total = 0
    for ii, val in enumerate(paths):
        if val == p:
            total += int(size[ii])
    size_by_path[p] = total

req_space = abs(40000000 - size_by_path["/"])

# Part 1 Answer
sum([s for s in size_by_path.values() if s <= 100000])

# Part 2 Answer
min([s for s in size_by_path.values() if s > req_space])
