with open("data/d18.txt", "r") as file:
    cords = file.read().split("\n")

cords = [[int(num) for num in item.split(",")] for item in cords]

hash_cords = [hash(str(c)) for c in cords]

free_side = 0

for c in cords:
    adj = [
        hash(str([c[0] + 1, c[1], c[2]])),
        hash(str([c[0] - 1, c[1], c[2]])),
        hash(str([c[0], c[1] + 1, c[2]])),
        hash(str([c[0], c[1] - 1, c[2]])),
        hash(str([c[0], c[1], c[2] + 1])),
        hash(str([c[0], c[1], c[2] - 1])),
    ]

    for h in adj:
        if h not in hash_cords:
            free_side += 1

free_side