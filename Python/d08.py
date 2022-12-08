import numpy as np

def view(x,y):
    if all([i > y for i in x]):
        return 1
    elif any([i >= y for i in x]):
        cnt = 0
        for ii in x:
            if ii < y:
                cnt += 1
            else:
                cnt += 1
                break
        return cnt
    else:
        return len(x)

def solve_p1(input):
    x = len(input[0])
    y = len(input)
    i = [int(i) for s in input for i in s]
    arr = np.array(i).reshape(x,y)
    rarr = np.zeros((x,y))

    for xx in range(x):
        for yy in range(y):

          val = arr[xx,yy]

          if xx in [0,x-1] or yy in [0,y-1]:
            rarr[xx,yy] = 1
          elif any([
                all([e < val for e in list(arr[0:xx,yy])]),
                all([e < val for e in list(arr[(xx+1):x,yy])]),
                all([e < val for e in list(arr[xx,0:yy])]),
                all([e < val for e in list(arr[xx,(yy+1):y])])
            ]):
            rarr[xx,yy] = 1

    return rarr.sum()

def solve_p2(input):
    x = len(input[0])
    y = len(input)
    i = [int(i) for s in input for i in s]
    arr = np.array(i).reshape(x,y)
    rarr = np.zeros((x,y))

    for xx in range(x):    
        for yy in range(y):
            val = arr[xx,yy]    
            if xx not in [0,x-1] and yy not in [0,y-1]:
                rarr[xx,yy] = 1
            if rarr[xx,yy] == 1:
                tmp = list(arr[0:(xx),yy])
                tmp.reverse()
                rarr[xx,yy] *= view(tmp,val)
                tmp = list(arr[(xx+1):x,yy])
                rarr[xx,yy] *= view(tmp,val)
                tmp = list(arr[xx,0:yy])
                tmp.reverse()
                rarr[xx,yy] *= view(tmp,val)
                tmp = list(arr[xx,(yy+1):y])
                rarr[xx,yy] *= view(tmp,val)

    return rarr.max()


with open("data/d08.txt") as f:
    input = f.read().split("\n")

# Part 1 Answer
print(solve_p1(input))

# Part 2 Answer
print(solve_p2(input))
