import multiprocessing as mp
import time

import matplotlib.pyplot as plt
from numpy import cos, isclose, linspace, pi, sin, unique, zeros
from scipy.optimize import fsolve

from root_main_s import t1

a = -3
b = 5
n = 4**9
x0 = linspace(a, b, n)
q = zeros(shape=(len(x0), 1))


def f(x):
    return sin(3 *  
               pi *
               cos(2 * pi * x) *
               sin(pi * x)
               )


def main(function, x0, _=None):
    return (fsolve(func=function, x0=x0))


p = []
fx = []


def func_append(i):
    '''
    This function append to p and fx
    '''
    p.append(i)
    fx.append(f(i))
    return True


if __name__ == "__main__":
    start_time = time.time()

    pool = mp.Pool(mp.cpu_count())
    q = pool.starmap(main, [(f, x0[i]) for i in range(n)])
    pool.close()

    tp = time.time() - start_time

    q = unique(q)  # type: ignore

    # Removing roots which does not give f(x)=0
    _ = [func_append(q[i]) for i in range(len(q)) if isclose(f(q[i]), 0.0)]


    print("\nOutput of 'root_main_p.py'")
    t1 = t1(n, x0)
    print("t1: ", t1)
    print("tp: ", tp)

    speed_up = t1/tp
    efficiency = (speed_up/mp.cpu_count()) * 100

    print("Speedup: ", speed_up)
    print("Efficiency: ", efficiency)

    # xx = linspace(a, b, 1001)
    # plt.plot(xx, f(xx))
    # plt.plot(p, fx, 'o')
    # plt.ylim([-1, 1])
    # plt.yticks([-1, 0, 1])
    # plt.xlabel('x')
    # plt.ylabel('f(x)')
    # plt.show()
