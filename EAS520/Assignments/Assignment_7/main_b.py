import multiprocessing as mp
import time
from itertools import repeat

import numpy as np
import numpy.typing as npt


def func(splited_array: npt.ArrayLike, op: str):
    if op == 'sum':
        return np.sum(splited_array)

    if op == 'average':
        return np.average(splited_array)

    if op == 'min':
        return np.min(splited_array)

    if op == 'max':
        return np.max(splited_array)

    return False


def my_map_reduce(v, nc: int, op: str):
    splited_array = np.vsplit(v, nc)
    p = mp.Pool(processes=nc)
    tic = time.time()
    split_result = p.starmap(func, zip(splited_array, repeat(op)))
    toc = time.time() - tic

    if split_result:
        return toc, func(split_result, op)
    return False


if __name__ == '__main__':
    m, n = 800, 1000  # Initializing size of matrix
    v = np.matrix(np.random.randint(low=1, high=10, size=m * n).reshape((m, n)))  # Initializing matrix
    operations = ['sum', 'average', 'min', 'max']  # Defining operations
    cores = [2, 4, 8]  # Defining number of cores to use in parallel computing

    for op in operations:
        for core in cores:
            time_taken, op_result = my_map_reduce(v=v, nc=core, op=op)
            print(f"Time taken: {time_taken} for operation '{op}' and result is {op_result} for core: {core}")
        print("")
