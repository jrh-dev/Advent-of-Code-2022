def req_rows(shape: list[int], placed: list[int]) -> int:
    new = max(set([x for x, _ in shape])) + 3
    if len(placed) != 0:
        exist = (
            max(set([x for x, _ in placed])) - min(set([x for x, _ in placed]))
        ) + 1
    else:
        exist = 0
    return new + exist


def can_move(shp_pos, placed, dir, grid_rows):
    if dir == ">":
        new_pos = [(r, c + 1) for r, c in shp_pos]
    elif dir == "<":
        new_pos = [(r, c - 1) for r, c in shp_pos]
    elif dir == "v":
        new_pos = [(r + 1, c) for r, c in shp_pos]

    for r, c in new_pos:
        if (r, c) in placed or r > grid_rows or c < 0 or c > 6:
            return (shp_pos, False)
        else:
            continue

    return (new_pos, True)


def tower_height(shapes: list[list[int]], jets: str, n_drops) -> int:
    i = 0
    j = 0
    dropped = 0
    placed = []
    shp_pos = shapes[j % len(shapes)]
    grid_rows = req_rows(shp_pos, placed)
    states = []

    while dropped < n_drops:
        jet = jets[i % len(jets)]

        if jet == ">":
            shp_pos, _ = can_move(shp_pos, placed, ">", grid_rows)
            shp_pos, moved = can_move(shp_pos, placed, "v", grid_rows)
        elif jet == "<":
            shp_pos, _ = can_move(shp_pos, placed, "<", grid_rows)
            shp_pos, moved = can_move(shp_pos, placed, "v", grid_rows)

        if moved:
            i += 1
        else:
            i += 1
            j += 1
            dropped += 1
            for pos in shp_pos:
                placed.append(pos)
            shp_pos = shapes[j % len(shapes)]
            grid_rows = req_rows(shp_pos, placed)
            drop_by = grid_rows - max(set([x for x, _ in placed]))
            for pos in range(len(placed)):
                placed[pos] = (placed[pos][0] + drop_by, placed[pos][1])

            "".join([f"{r}{c}" for r, c in placed if r <= 10])

            states.append((max(set([x for x, _ in placed])) - min(set([x for x, _ in placed]))) + 1)

    height = (max(set([x for x, _ in placed])) - min(set([x for x, _ in placed]))) + 1

    return (height, states)


# shapes
shapes = [
    [(0, 2), (0, 3), (0, 4), (0, 5)],
    [(0, 3), (1, 2), (1, 3), (1, 4), (2, 3)],
    [(0, 4), (1, 4), (2, 2), (2, 3), (2, 4)],
    [(0, 2), (1, 2), (2, 2), (3, 2)],
    [(0, 2), (0, 3), (1, 2), (1, 3)],
]

jets = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"

with open("data/d17.txt", "r") as file:
    jets = file.read()

height, pattern = tower_height(shapes, jets, 2022)

