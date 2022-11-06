import multiprocessing as mp
import random
import time
from itertools import repeat

import numpy as np
import numpy.typing as npt


def func(split_array: npt.ArrayLike, op: str):
    if op == 'sum':
        return sum(split_array)

    if op == 'average':
        return np.average(split_array)

    if op == 'min':
        return min(split_array)

    if op == 'max':
        return max(split_array)

    return False


def my_map_reduce(v: npt.ArrayLike, nc: int, op: str):
    split_array = np.array_split(v, nc)
    p = mp.Pool(processes=nc)
    tic = time.time()
    split_result = p.starmap(func, zip(split_array, repeat(op)))
    toc = time.time() - tic

    if split_result:
        return toc, func(split_result, op)
    return False


if __name__ == '__main__':
    v = np.random.randint(low=1, high=9, size=100000000)
    operations = ['sum', 'average', 'min', 'max']

    for op in operations:
        for core in [2, 4, 8]:
            time_taken, op_result = my_map_reduce(v=v, nc=core, op=op)
            print(f"Time taken: {time_taken} for operation '{op}' and result is {op_result} for core: {core}")
        print("")
