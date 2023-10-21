def surface_area(cords: list[int]) -> int:
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

    return free_side


def cooling_area(cords: list[int]) -> int:
    hash_cords = [hash(str(c)) for c in cords]

    x_range = min([c[0] for c in cords]) - 1, max([c[0] for c in cords]) + 1
    y_range = min([c[1] for c in cords]) - 1, max([c[1] for c in cords]) + 1
    z_range = min([c[2] for c in cords]) - 1, max([c[2] for c in cords]) + 1

    start = [x_range[0], y_range[0], z_range[0]]

    cool_side = 0

    check = []
    done = []

    check.append(start)

    while len(check) > 0:
        cur = check.pop(0)

        catch_hash = hash(str(cur))

        if catch_hash in done:
            continue

        done.append(catch_hash)

        adj = [
            [cur[0] + 1, cur[1], cur[2]],
            [cur[0] - 1, cur[1], cur[2]],
            [cur[0], cur[1] + 1, cur[2]],
            [cur[0], cur[1] - 1, cur[2]],
            [cur[0], cur[1], cur[2] + 1],
            [cur[0], cur[1], cur[2] - 1],
        ]

        for c in adj:
            off_hash = hash(str(c))
            if c[0] < x_range[0] or c[0] > x_range[1]:
                done.append(off_hash)
            if c[1] < y_range[0] or c[1] > y_range[1]:
                done.append(off_hash)
            if c[2] < z_range[0] or c[2] > z_range[1]:
                done.append(off_hash)
            if hash(str(c)) in hash_cords:
                cool_side += 1
            else:
                check.append(c)

    return cool_side


if __name__ == "__main__":
    with open("data/d18.txt", "r") as file:
        cords = file.read().split("\n")

    cords = [[int(num) for num in item.split(",")] for item in cords]

    # Part 1 answer
    print(surface_area(cords))

    # Part 2 answer
    print(cooling_area(cords))
