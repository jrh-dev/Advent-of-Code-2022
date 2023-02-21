import numpy as np
import numpy.typing as npt


def make_matrices(matrix: npt.ArrayLike, part_1: bool) -> list[npt.ArrayLike]:
    """
    create numpy arrays to test valid moves (real_mat) and
    track path length (count_mat)
    """
    # pad path counter array with 999, and default value 998
    count_mat = np.pad(np.full(matrix.shape, 998), 1,
                       mode='constant', constant_values=999)
    # pad actual raw value array with 999
    real_mat = np.pad(matrix, 1, mode='constant', constant_values=999)

    # part_1 looks for single start point, else multiple starts allowed
    if part_1:
        sy = int(np.where(real_mat == 83)[0])
        sx = int(np.where(real_mat == 83)[1])
        count_mat[sy, sx] = -1
    else:
        sy = np.where(real_mat == 97)[0]
        sx = np.where(real_mat == 97)[1]
        for y, x in zip(sy, sx):
            count_mat[y, x] = -1

    # detect finish points
    fy = np.where(real_mat == 69)[0]
    fx = np.where(real_mat == 69)[1]

    # convert start and finish points
    real_mat[sy, sx] = ord('a')
    real_mat[fy, fx] = ord('z')

    return [count_mat, real_mat]


def get_mvs(cur_loc: tuple) -> list[tuple]:
    """ get valid next move coordinates from a specified position """
    mvs = [(cur_loc[0]-1, cur_loc[1]), (cur_loc[0], cur_loc[1]+1),
           (cur_loc[0]+1, cur_loc[1]), (cur_loc[0], cur_loc[1]-1)]
    return mvs


def solve(matrix: npt.ArrayLike, part_1: bool) -> int:
    """ 
    solver for AoC 2022 day 12 parts 1 & 2
    """
    step = 0

    fy = np.where(matrix == 69)[0] + 1
    fx = np.where(matrix == 69)[1] + 1

    count_mat, real_mat = make_matrices(matrix, part_1)

    run = True
    while step < 10000 and run:
        from_y = [int(i) for i in np.where(count_mat == count_mat.min())[0]]
        from_x = [int(i) for i in np.where(count_mat == count_mat.min())[1]]

        step += 1

        for y, x in zip(from_y, from_x):

            if (y, x) == (fy, fx):
                run = False
            mvs = get_mvs((y, x))

            for mv in mvs:
                if real_mat[mv] - real_mat[(y, x)] < 2 and count_mat[mv] > step and count_mat[mv] != 999:
                    count_mat[mv] = step
                count_mat[(y, x)] = 999

    return step-1


with open('d12.txt') as f:
    input = f.read().split('\n')

mat = []

for s in input:
    mat.append([ord(l) for l in s])

mat = np.array(mat)

# Part 1 Answer
solve(matrix=mat, part_1=True)

# Part 2 Answer
solve(matrix=mat, part_1=False)
