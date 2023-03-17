import re
from typing import Generator

class SensorNet:

    def __init__(self, input):
        self.input = input

    def parse_coords(self, line: str) -> tuple[tuple, tuple, int]:
        """
        Parse a line of input into a tuple of coordinates 
        (scanner and beacon) and distance.
        """
        x1 = int(line.split("x=")[1].split(",")[0])
        y1 = int(line.split("y=")[1].split(":")[0])
        x2 = int(line.split("x=")[2].split(",")[0])
        y2 = int(line.split("y=")[2].split(":")[0])
        dif = abs(x1 - x2) + abs(y1 - y2)
        return [(x1, y1), (x2, y2), dif]

    def get_coords(self, input: list[str]) -> Generator[tuple, None, None]:
        """
        Generator to parse input into coordinates.
        Wrapper for parse_coords
        """
        for line in input:
            yield self.parse_coords(line)

    def in_range(self, x: int, a: int, b: int) -> bool:
        """Check if x is within range of a and b."""
        return x >= a and x <= b or x >= b and x <= a

    def diff(self, a: int, b:int) -> int:
        """Return the absolute difference between a and b."""
        return abs(a - b)
    
    def solve_p1(self, tar_row: int) -> int:
        """
        Solve part 1 of the problem; find the number of points
        in a given row that are not in range of any scanner
        and not the position of a beacon.
        Args:
            tar_row (int): The row to check for beacons.
        """
        coords = self.get_coords(self.input)

        not_here = set()
        beacons = set()

        for b, s, d in coords: # b = beacon, s = scanner, d = distance
            if s[1] == tar_row:
                beacons.add(s[0])

            if (off := self.diff(b[1], tar_row)) <= d:
                expand = d - off
                for i in range(b[0] - expand, b[0] + expand + 1):
                    if i not in beacons:
                        not_here.add(i)
                    else:
                        continue
            else:
                continue

        return len(not_here)
    
    
    def md(p: int, q: int) -> int:
        """
        Manhattan distance between two points.
        """
        return abs(p[0]-q[0])+abs(p[1]-q[1])
    
    def solve_p2(self, bound: int) -> int:
        """
        Solve part 2 of the problem; find the location of the
        distress call.
        Args:
            bound (int): The maximum value of the coordinates.

        CREDIT for intersection solution: 
        https://www.reddit.com/user/i_have_no_biscuits/
        https://www.reddit.com/r/adventofcode/comments/zmcn64/comment/j0b90nr/?utm_source=reddit&utm_medium=web2x&context=3
        """
        coords = [c for c in self.get_coords(self.input)]

        aco = bco = set() # sets to collect coefficients
        for beacon, _, d  in coords:
            x, y = beacon
            aco.add(y-x+d+1)
            aco.add(y-x-d-1)
            aco.add(x+y+d+1)
            aco.add(x+y-d-1)

        for a in aco:
            for b in bco:
                p = ((b-a)//2, (a+b)//2) # point of intersection
                if all(0 < c < bound for c in p): # check if in bounds
                    if all(self.md(p, c[0]) > c[2] for c in coords): # check if in range
                        return(bound * p[0] + p[1])







if __name__ == '__main__':

    with open('data/d15.txt') as f:
        input = f.read().split('\n')

    sensor_net = SensorNet(input)
    
    # Part 1 Answer
    print(sensor_net.solve_p1(2_000_000))

    # Part 2 Answer
    print(sensor_net.solve_p2(4_000_000))

