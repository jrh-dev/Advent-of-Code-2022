with open("data/d04.txt") as f:
    input = f.read().split("\n")

class clean:
    def __init__(self, input):
        self.unpack = self.__unpack(input)
        self.contain = self.__contain(self.unpack )
        self.overlap = self.__overlap(self.unpack)

    def __unpack(self, inp):
        out = [s.split(',') for s in input]
        for ii in range(len(out)):
            out[ii] = [s.split('-') for s in out[ii]]
        return out

    def __contain(self, inp):
        cnt = 0
        for ii in range(len(inp)):
            lhsa = int(inp[ii][0][0])
            lhsb = int(inp[ii][0][1])
            rhsa = int(inp[ii][1][0])
            rhsb = int(inp[ii][1][1])

            if  ((self.__between(lhsa, rhsa, rhsb) and
                 self.__between(lhsb, rhsa, rhsb)) or
                 (self.__between(rhsa, lhsa, lhsb) and 
                 self.__between(rhsb, lhsa, lhsb))):
                 cnt += 1
            else:
                continue
        return cnt

    def __overlap(self, inp):
        cnt = 0
        for ii in range(len(inp)):
            lhsa = int(inp[ii][0][0])
            lhsb = int(inp[ii][0][1])
            rhsa = int(inp[ii][1][0])
            rhsb = int(inp[ii][1][1])

            if not(max(lhsa,lhsb) < min(rhsa,rhsb) or 
                min(lhsa,lhsb) > max(rhsa,rhsb)):
                cnt +=1
            else:
                continue
        return cnt

    def __between(self, x, y, z):
        return x >= y and x <= z

camp_cleanup = clean(input)

# Part 1 Answer
print(camp_cleanup.contain)

# Part 2 Answer
print(camp_cleanup.overlap)
