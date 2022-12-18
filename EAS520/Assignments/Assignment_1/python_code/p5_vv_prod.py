# Dot Product of 2 vectors

from time import time

import numpy as np

n = 10000  # Length of the vectors

a = np.random.rand(n, 1)  # Create a random column vector a
b = np.random.rand(n, 1)  # Create a random column vector b

c = 0  # pre-allocate memory to store the result in c

# Dot product with for-loop
t1 = time()
for i in range(n):
    c += a[i] * b[i]
t2 = time()

time_loop = t2 - t1


# Dot product with numpy
t3 = time()

cc = np.vdot(a, b)

t4 = time()

time_numpy = t4 - t3


# Compare the results
norm = np.linalg.norm(cc - c)

# Measure the speed-up
speedup = time_loop / time_numpy

print(cc-c)
print("n: ", n)
print("norm: ", norm)
print("Speedup: ", speedup)
