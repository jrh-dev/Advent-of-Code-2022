with open("data/d04.txt") as f:
    input = f.read().split("\n")

def between(x, y, z):
    return x >= y and x <= z

con = 0
ovr = 0


for line in input:
    l,r = line.split(",")
    la, lb = l.split("-")
    ra, rb = r.split("-")

    p = [int(e) for e in [la,lb,ra,rb]]

    if ((between(p[0], p[2], p[3]) and between(p[1], p[2], p[3])) or
        (between(p[2], p[0], p[1]) and between(p[3], p[0], p[1]))):
        con += 1

    if not(max(p[0],p[1]) < min(p[2],p[3]) or 
            min(p[0],p[1]) > max(p[2],p[3])):
        ovr += 1

# Part 1 Answer
print(con)

# Part 2 Answer
print(ovr)