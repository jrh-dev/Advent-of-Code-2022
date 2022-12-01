f = open("data/d01.txt", "r")

input = f.read().split("\n")

f.close()

input = [int(x) if x not in '' else None for x in input]

splits = [i for i, e in enumerate(input) if e == None]

splits.append(len(input))

res = []

start = 0

for ii in range(len(splits)):
    res.append(sum(input[start:splits[ii]]))
    start = splits[ii] + 1
  
res.sort(reverse=True)

# Part 1 Answer
print(sum(res[0:1]))

# Part 2 Answer
print(sum(res[0:3]))