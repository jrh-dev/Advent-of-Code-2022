from math import floor, prod


class Monkey:

    def __init__(self, holding: list[int], worry_div: int,
                 test_div: int, modulus: bool, inspected: int):
        self.inspected = inspected
        self.giving = self.throw_to(holding=holding, worry_div=worry_div,
                                    test_div=test_div, modulus=modulus)

    def throw_to(self, holding: list[int], worry_div: int,
                 test_div: int, modulus: bool):

        option_1 = []
        option_2 = []

        for item in holding:
            item = int(floor(item / worry_div))
            if modulus:
                item = item % (2*7*3*11*17*5*13*19)
            if item % test_div == 0:
                option_1.append(item)
            else:
                option_2.append(item)

        return (option_1, option_2)


def solve(start_state, modulus, n_rounds, div_by):

    m_0, m_1, m_2, m_3, m_4, m_5, m_6, m_7 = start_state

    monkey0 = Monkey([], 0, 0, modulus, 0)
    monkey1 = Monkey([], 0, 0, modulus, 0)
    monkey2 = Monkey([], 0, 0, modulus, 0)
    monkey3 = Monkey([], 0, 0, modulus, 0)
    monkey4 = Monkey([], 0, 0, modulus, 0)
    monkey5 = Monkey([], 0, 0, modulus, 0)
    monkey6 = Monkey([], 0, 0, modulus, 0)
    monkey7 = Monkey([], 0, 0, modulus, 0)

    for _ in range(0, n_rounds):

        monkey0 = Monkey(holding=[n * 3 for n in m_0], worry_div=div_by, test_div=11,
                         modulus=modulus, inspected=monkey0.inspected + len(m_0))
        m_0 = []
        m_2 = m_2 + monkey0.giving[0]
        m_7 = m_7 + monkey0.giving[1]

        monkey1 = Monkey(holding=[n * n for n in m_1], worry_div=div_by, test_div=7,
                         modulus=modulus, inspected=monkey1.inspected + len(m_1))
        m_1 = []
        m_0 = m_0 + monkey1.giving[0]
        m_2 = m_2 + monkey1.giving[1]

        monkey2 = Monkey(holding=[n + 1 for n in m_2], worry_div=div_by, test_div=3,
                         modulus=modulus, inspected=monkey2.inspected + len(m_2))
        m_2 = []
        m_7 = m_7 + monkey2.giving[0]
        m_5 = m_5 + monkey2.giving[1]

        monkey3 = Monkey(holding=[n + 8 for n in m_3], worry_div=div_by, test_div=5,
                         modulus=modulus, inspected=monkey3.inspected + len(m_3))
        m_3 = []
        m_6 = m_6 + monkey3.giving[0]
        m_4 = m_4 + monkey3.giving[1]

        monkey4 = Monkey(holding=[n + 3 for n in m_4], worry_div=div_by, test_div=17,
                         modulus=modulus, inspected=monkey4.inspected + len(m_4))
        m_4 = []
        m_1 = m_1 + monkey4.giving[0]
        m_0 = m_0 + monkey4.giving[1]

        monkey5 = Monkey(holding=[n + 4 for n in m_5], worry_div=div_by, test_div=13,
                         modulus=modulus, inspected=monkey5.inspected + len(m_5))
        m_5 = []
        m_6 = m_6 + monkey5.giving[0]
        m_3 = m_3 + monkey5.giving[1]

        monkey6 = Monkey(holding=[n * 17 for n in m_6], worry_div=div_by, test_div=19,
                         modulus=modulus, inspected=monkey6.inspected + len(m_6))
        m_6 = []
        m_4 = m_4 + monkey6.giving[0]
        m_1 = m_1 + monkey6.giving[1]

        monkey7 = Monkey(holding=[n + 7 for n in m_7], worry_div=div_by, test_div=2,
                         modulus=modulus, inspected=monkey7.inspected + len(m_7))
        m_7 = []
        m_5 = m_5 + monkey7.giving[0]
        m_3 = m_3 + monkey7.giving[1]

    monkey_business = [
        monkey0.inspected,
        monkey1.inspected,
        monkey2.inspected,
        monkey3.inspected,
        monkey4.inspected,
        monkey5.inspected,
        monkey6.inspected,
        monkey7.inspected
    ]

    monkey_business.sort(reverse=True)

    return prod(monkey_business[0:2])


with open("data/d11.txt") as f:
    input = f.read().split("\n")

# Part 1 Answer
solve([[50, 70, 54, 83, 52, 78],
       [71, 52, 58, 60, 71],
       [66, 56, 56, 94, 60, 86, 73],
       [83, 99],
       [98, 98, 79],
       [76],
       [52, 51, 84, 54],
       [82, 86, 91, 79, 94, 92, 59, 94]], False, 20, 3)

# Part 2 Answer
solve([[50, 70, 54, 83, 52, 78],
       [71, 52, 58, 60, 71],
       [66, 56, 56, 94, 60, 86, 73],
       [83, 99],
       [98, 98, 79],
       [76],
       [52, 51, 84, 54],
       [82, 86, 91, 79, 94, 92, 59, 94]], True, 10000, 1)
