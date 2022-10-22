from time import time

import numpy as np

n = 10000

A = np.random.rand(n, n)  # Create a Matrix of size n,n
b = np.random.rand(n, 1)  # Create a random column vector b

c = np.zeros((n, 1))  # pre-allocate memory to store the result in c


# Dot product with numpy
t1 = time()

cc = np.dot(A, b)

t2 = time()

time_numpy = t2 - t1


# Dot product with for-loop

t3 = time()
for i in range(n):
    for j in range(n):
        c[i] += A[i][j] * b[j]


t4 = time()

time_loop = t4 - t3


# Compare the results
norm = np.linalg.norm(cc - c)

# Measure the speed-up
speedup = time_loop / time_numpy


print("n: ", n)
print("norm: ", norm)
print("Speedup: ", speedup)
