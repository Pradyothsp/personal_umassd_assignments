library(pracma)

n <- 1000
A <- rand(n, n)
B <- rand(n, n)

C <- zeros(n, n)


# Using vectorization
t1 <- Sys.time()
CC = A%*%B
t2 <- Sys.time()

time_vec = t2 - t1


# Using for-loop

t3 <- Sys.time()
for (i in 1:n) {
  for (j in 1:n) {
    for (k in 1:n) {
      C[i, j] <- C[i, j] + A[i, k] * B[k, j]
    }
  }
}

t4 <- Sys.time()

time_loop = t4 - t3


norm <- norm(CC-C)

speed_up <- as.double(time_loop, units='secs') / as.double(time_vec, units='secs')

n
norm
speed_up
