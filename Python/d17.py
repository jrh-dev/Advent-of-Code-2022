# shapes
shapes = [
    [(0, 2), (0, 3), (0, 4), (0, 5)],
    [(0, 3), (1, 2), (1, 3), (1, 4), (2, 3)],
    [(0, 4), (1, 4), (2, 2), (2, 3), (2, 4)],
    [(0, 2), (1, 2), (2, 2), (3, 2)],
    [(0, 2), (0, 3), (1, 2), (1, 3)],
]


# class for shapes
class Shape:
    """
    A class to represent a 2d shape by recording each
    of its individual coordinates.
    """

    def __init__(self, shape: list[set[int]]):
        self.shape = shape

    def __repr__(self) -> str:
        return f"Shape({self.shape})"

    def req_rows(self) -> int:
        """
        Calculate how many rows are required to fit the shape.
        """
        return len(set([x for x, _ in self.shape])) + 3


jets = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"


# move the shapes left
def move_left(shape: list[set[int]]) -> list[set[int]]:
    shape = []
    for point in shape:
        x, y = point
        shape.append((x - 1, y))
    return shapes


# move the shapes right
def move_right(shape: list[set[int]]) -> list[set[int]]:
    shape = []
    for point in shape:
        x, y = point
        shape.append((x + 1, y))
    return shapes


# move the shapes down
def move_down(shape: list[set[int]]) -> list[set[int]]:
    shape = []
    for point in shape:
        x, y = point
        shape.append((x, y + 1))
    return shapes


grid = [[0, 0, 1, 0, 0, 0, 0]]

test_shape = [(2, 0)]


def can_move(shape: list[set[int]], grid: list[list[int]]) -> bool:
    for point in shape:
        x, y = point
        if grid[y][x] == 1:
            return False
    return True


