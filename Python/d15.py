import numpy as np




def extract_coords(line):
    x1 = int(line.split("x=")[1].split(",")[0])
    y1 = int(line.split("y=")[1].split(":")[0])
    x2 = int(line.split("x=")[2].split(",")[0])
    y2 = int(line.split("y=")[2].split(":")[0])
    dif = abs(x1 - x2) + abs(y1 - y2)
    return x1, y1, x2, y2, dif


with open('data/d15.txt') as f:
    input = f.read().split('\n')

coords = []
for line in input:
    coords.append(extract_coords(line))

no_beacon = set()

target_row = 2000000
for detail in coords:
    dist = detail[4]
    #print(detail)
    #print(target_row in range(detail[1]-dist, detail[1] + dist + 1))
    if target_row in range(detail[1]-dist, detail[1] + dist + 1):
        #print(f'overlaps')
        offset = dist - abs(target_row - detail[1])
        for i in range(detail[0] - offset, detail[0] + offset + 1):
            if (i,target_row) != (detail[2], detail[3]):
                #print((i,target_row))
                no_beacon.add((i,target_row))

# Part 1 Answer
print(len(no_beacon))

