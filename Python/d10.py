
class CathodeRayTube:

    def __init__(self, input, observe):
        self.observe = observe
        self.observations = self.get_observations(input)
        self.crt_draw = list(self.draw(observation=self.observations))

    def instruct_gen(self, input):
        for i in input:
            try:
                dir, mv = i.split()
            except:
                dir, mv = (i, 0)
            yield (dir, int(mv))

    def get_observations(self, input):
        instructions = self.instruct_gen(input=input)
        cycles = 1
        x = 1
        observation = [1]

        while cycles < 241:

            do, n = next(instructions)

            if do == 'noop':
                cycles += 1
                observation.append(x)
                continue
            else:
                cycles += 1
                observation.append(x)
                cycles += 1
                x += n
                observation.append(x)

        return observation

    def draw(self, observation):
        pixel = 0
        offset = 0
        for obs in observation:
            pixel += 1
            if pixel % 40 == 0:
                offset += 1
            if pixel - (40 * offset) in range(obs, obs+3):
                yield '#'
            else:
                yield ' '

    def part_1(self):
        return sum([self.observations[x-1] * x for x in self.observe])

    def part_2(self):
        s = 0
        f = 39
        for _ in range(0, 6):
            print(''.join(self.crt_draw[s:f]))
            s += 40
            f += 40


with open("data/d10.txt") as f:
    input = f.read().split("\n")


crt = CathodeRayTube(input, [20, 60, 100, 140, 180, 220])

crt.part_1()

crt.part_2()
