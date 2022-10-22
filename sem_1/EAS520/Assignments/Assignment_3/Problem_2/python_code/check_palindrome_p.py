import multiprocessing as mp
import time

from check_palindrome import (check_palindrome, get_all_files,
                              get_string_from_file)

if __name__ == '__main__':
    start_time = time.time()

    for file in get_all_files():
        _ = check_palindrome(get_string_from_file(file=file))

    t1 = time.time() - start_time

    list_string = [get_string_from_file(file) for file in get_all_files()]

    start_time = time.time()
    pool = mp.Pool(mp.cpu_count())
    result = pool.starmap(
        check_palindrome,
        [(s, None) for s in list_string])
    pool.close()

    tp = time.time() - start_time

    print("t1: ", t1)
    print("tp: ", tp)

    speed_up = t1/tp
    efficiency = (speed_up/mp.cpu_count()) * 100

    print("Speedup: ", speed_up)
    print("Efficiency: ", efficiency)
