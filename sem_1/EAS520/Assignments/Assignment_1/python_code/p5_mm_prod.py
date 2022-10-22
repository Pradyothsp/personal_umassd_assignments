from time import time

import numpy as np

n = 1000

A = np.random.rand(n, n)  # Create a Matrix A of size n,n
B = np.random.rand(n, n)  # Create a Matrix B of size n,n

c = np.zeros((n, n))  # pre-allocate memory to store the result in c


# Dot product with numpy
t1 = time()

cc = np.dot(A, B)

t2 = time()

time_numpy = t2 - t1


# Dot product with for-loop

t3 = time()
for i in range(n):
    for j in range(n):
        for k in range(n):
            c[i][j] += A[i][k] * B[k][j]

t4 = time()

time_loop = t4 - t3


# Compare the results
norm = np.linalg.norm(cc - c)

# Measure the speed-up
speedup = time_loop / time_numpy


print("n: ", n)
print("norm: ", norm)
print("Speedup: ", speedup)
