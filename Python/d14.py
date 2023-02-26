import numpy as np
import pandas as pd


def cave_scan(input: list[str]) -> np.array:
    rock_coord = []
    max_y = 0
    max_x = 0

    for inp in input:
        inp = inp.split('->')
        inp = [e.strip().split(',') for e in inp]
        for i in range(0, len(inp)-1):
            sx, sy, fx, fy = [int(e) for e in inp[i] + inp[i+1]]
            max_y = max(max_y, sy, fy)
            max_x = max(max_x, sx, fx)
            rock_coord.append((sy, sx))
            rock_coord.append((fy, fx))

            if sy == fy:
                for n in range(min(sx, fx)+1, max(sx, fx)):
                    rock_coord.append((sy, n))
            else:
                for n in range(min(sy, fy)+1, max(sy, fy)):
                    rock_coord.append((n, sx))

    grid = np.zeros((max_y + 3, max_x + max_y + 3))

    for coord in rock_coord:
        grid[coord[0], coord[1]] = 99

    grid[max_y + 2, :] = 99

    return grid


def sand_flow(grid: np.array, drop_x: int) -> tuple[int, int]:
    drop_x = 500
    drop_y = 0
    max_y = grid.shape[0] - 2
    x = drop_x
    y = drop_y
    sand = 0
    run = True
    p1_ans = 0
    p2_ans = 0

    while run:

        curr = (y, x)
        if grid[y+1, x] == 0:
            y += 1
        elif grid[y+1, x-1] == 0:
            y += 1
            x -= 1
        elif grid[y+1, x+1] == 0:
            y += 1
            x += 1

        if (y == max_y) and (p1_ans == 0):
            p1_ans = sand
            grid[y, x] = 1
            sand += 1
            y = drop_y
            x = drop_x
        elif curr == (y, x):
            grid[y, x] = 1
            sand += 1
            y = drop_y
            x = drop_x

        if grid[drop_y, drop_x] == 1:
            p2_ans = sand
            run = False

    return p1_ans, p2_ans


if __name__ == '__main__':

    with open('data/d14.txt') as f:
        input = f.read().split('\n')

    grid = cave_scan(input)

    ans = sand_flow(grid, 500)

    # Part 1 Answer
    print(ans[0])

    # Part 2 Answer
    print(ans[1])
