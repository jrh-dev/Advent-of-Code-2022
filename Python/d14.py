import numpy as np

with open('eed14.txt') as f:
    input = f.read().split('\n')


rock_coord = []
max_y = 0
max_x = 0

for inp in input:
    #print(inp)
    inp = inp.split('->')
    inp = [e.strip().split(',') for e in inp]
    for i in range(0, len(inp)-1):
        sy, sx, fy, fx = [int(e) for e in inp[i] + inp[i+1]]
        #print(sy, sx, fy, fx)
        max_y = max(max_y, sy, fy)
        max_x = max(max_x, sx, fx)
        rock_coord.append((sy, sx))
        rock_coord.append((fy, fx))

        if sy == fy:
            for n in range(min(sx,fx)+1, max(sx,fx)):
                print(n)
                rock_coord.append((sy, n))
        else: 
            for n in range(min(sy,fy)+1, max(sy,fy)):
                print(n)
                rock_coord.append((n, sx))

grid = np.zeros((max_y + 2, max_x + 2))

for coord in rock_coord:
    grid[coord[0],coord[1]] = 99



def down(y, x, grid, void):
    y += 1
    if y == void:
        return 3 # 3 fell into void
    elif grid[y,x] == 0:
        return 2 # can move down
    else:
        return 1 # can't move down

def left(y, x, grid, void):
    y += 1
    x -= 1
    if (y == void) and (grid[y-1,x] == 0):
        return 3 # fell into void
    elif (grid[y,x] == 0) and (grid[y-1,x] == 0):
        return 2 # can move left
    else:
        return 1 # can't move left

def left(y, x, grid, void):
    y += 1
    x += 1
    if (y == void) and (grid[y-1,x] == 0):
        return 3 # fell into void
    elif (grid[y,x] == 0) and (grid[y-1,x] == 0):
        return 2 # can move left
    else:
        return 1 # can't move left


void = max_y + 2
run = True
sand = 0

y=3
x=0

free = True


while free and run:
    sand += 1
    down_status = down(y,x,grid,void)
    if down_status == 3:
        run = False
        break
    elif down_status == 2:
    down_status = down(y,x,grid,void)
    if down_status == 3:
        run = False
        break










