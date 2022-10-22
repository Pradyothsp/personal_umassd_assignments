import time

import matplotlib.pyplot as plt
from numpy import cos, isclose, linspace, pi, sin
from scipy.optimize import fsolve

a = -3
b = 5


def f(x):
    return sin(3 *
               pi *
               cos(2 * pi * x) *
               sin(pi * x)
               )


start_time = time.time()
root = fsolve(func=f, x0=0.5)
elapsed_time = time.time() - start_time

print("Output of 'root_main.py'")
print("Root: ", root)
print(isclose(f(root), 0.0))
print("Elapsed time: ", elapsed_time)

# xx = linspace(a, b, 1001)
# plt.plot(xx, f(xx))
# plt.plot(root, f(root), 'o')
# plt.ylim([-1, 1])
# plt.yticks([-1, 0, 1])
# plt.xlabel('x')
# plt.ylabel('f(x)')
# plt.show()
