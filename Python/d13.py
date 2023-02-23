from itertools import zip_longest
from math import prod
from collections.abc import Iterator

class Decoder:
    """
    Class to handle decoding of Elvish distress signal.
    AoC 2022 - day 13
    """

    def __init__(self, path: str, dividers: list):
        self.path = path
        self.part_1 = self.solve_p1(self.path)
        self.part_2 = self.solve_p2(self.path, dividers)

    def _get_input(self, path: str) -> Iterator[list, list]:
        """
        read raw data and pair packets for comparison
        """
        with open(path) as f:
            input = f.read().split('\n')

        input = [eval(x) for x in input if x != '']
        input = zip(input[::2], input[1::2])

        return input

    def compare(self, l: list, r: list) -> int:
        """
        unpack and compare packets
        """
        match l, r:
            case int(), int(): return (l < r) - (l > r)
            case int(), list(): return self.compare([l], r)
            case list(), int(): return self.compare(l, [r])
            case list(), list():
                for z in map(self.compare, l, r):
                    if z:
                        return z
                return self.compare(len(l), len(r))

    def _get_index(self, input: Iterator[list, list], divider: list, offset: int) -> int:
        """
        get the index (from 1 not 0) of a divider packer
        """        
        index = 0 + offset
        for a, b in input:
            index += (max(self.compare(a, divider), 0) +
                      max(self.compare(b, divider), 0))
        return index

    def solve_p1(self, path: str) -> int:
        """
        solve part 1 - how many pairs are in the correct order?
        """
        in_order = 0
        for index, order in enumerate(self._get_input(path), 1):
            if self.compare(*order) == 1:
                in_order += index
        return in_order

    def solve_p2(self, path: str, dividers: list) -> int:
        """
        solve part 2 - the product of index position (from 1 not 0) 
        of the specified dividers
        """
        res = []
        for divider, offset in zip(dividers, range(1, len(dividers)+1)):
            res.append(self._get_index(self._get_input(path), divider, offset))
        return prod(res)


signal = Decoder('data/d13.txt', [[[2]], [[6]]])

# Part 1 Answer
signal.part_1

# Part 2 Answer
signal.part_2
