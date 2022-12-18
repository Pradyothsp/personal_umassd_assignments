import time

import matplotlib.pyplot as plt
from numpy import cos, isclose, linspace, pi, sin, unique, zeros
from scipy.optimize import fsolve

# a = -3
# b = 5
# n = 4**9
# x0 = linspace(a, b, n)


def f(x):
    return sin(3 *
               pi *
               cos(2 * pi * x) *
               sin(pi * x)
               )


def t1(n, x0):
    q = zeros(shape=(len(x0), 1))
    start_time = time.time()

    for i in range(n):
        q[i] = fsolve(func=f, x0=x0[i])

    return time.time() - start_time

# q = unique(q)


# print("Root: ", q)
# # print(isclose(f(q), 0.0))

# p = []
# fx = []

# def func_append(i):
#     '''
#     This function append to p and fx
#     '''
#     p.append(i)
#     fx.append(f(i))
#     return True

# # Removing roots which does not give f(x)=0
# _ = [func_append(q[i]) for i in range(len(q)) if isclose(f(q[i]), 0.0)]

# print("Elapsed time: ", t1)

# xx = linspace(a, b, 1001)
# plt.plot(xx, f(xx))
# plt.plot(p, fx, 'o')
# plt.ylim([-1, 1])
# plt.yticks([-1, 0, 1])
# plt.xlabel('x')
# plt.ylabel('f(x)')
# plt.show()
