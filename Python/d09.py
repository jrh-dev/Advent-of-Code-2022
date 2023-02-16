
class Knots:
    """
    Solve day 9 Aoc 2022
    """

    def __init__(self, input: list[tuple[str, int]], n_knots: int):
        self.input = input
        self.n_knots = n_knots
        self.hpos = self.first_head(input=self.input)
        self.knot_pos = self.get_knots(n_knots=self.n_knots, head=self.hpos)

    def first_head(self, input: list[tuple[int, int]]) -> list[tuple[int, int]]:
        """
        Record the 2 dimensional position of the 'head' of the rope
        at any given point in time.
        """
        res = []
        x = 0
        y = 0
        for mv in input:
            direction, distance = mv
            for _ in range(0, distance):
                if direction == 'R':
                    x += 1
                elif direction == 'L':
                    x -= 1
                elif direction == 'U':
                    y += 1
                elif direction == 'D':
                    y -= 1
                res.append((x, y))
        return res

    def get_knots(self, n_knots: int, head: list[tuple[int, int]]) -> list[tuple[int, int]]:
        """
        Record the 2 dimensional position of any 'knot' in the rope
        at any given point in time.
        """
        knots = []
        for _ in range(0, n_knots):
            knot = [(0, 0)]
            for position in head:
                tail_x, tail_y = knot[len(knot)-1]
                head_x, head_y = position
                while abs(head_x - tail_x) > 1 or abs(head_y - tail_y) > 1:

                    if (head_x > tail_x) and ((tail_x + 1, tail_y) != (head_x, head_y)):
                        tail_x += 1
                    elif (head_x < tail_x) and ((tail_x - 1, tail_y) != (head_x, head_y)):
                        tail_x -= 1

                    if (head_y > tail_y) and ((tail_x, tail_y + 1) != (head_x, head_y)):
                        tail_y += 1
                    elif (head_y < tail_y) and ((tail_x, tail_y - 1) != (head_x, head_y)):
                        tail_y -= 1

                    knot.append((tail_x, tail_y))

            knots.append(knot)
            head = knots[len(knots)-1]
        return knots


with open("data/d09.txt") as f:
    input = f.read().split("\n")

dat = []

for i in input:
    dir, mv = i.split()
    dat.append((dir, int(mv)))

rope = Knots(dat, 9)

# Part 1 Answer
print(len(set(rope.knot_pos[0])))

# Part 2 Answer
print(len(set(rope.knot_pos[8])))
