library(pracma)

n <- 10000
A <- rand(n, n)
b <- runif(n)

C <- zeros(n, 1)

# Using vectorization
t1 <- Sys.time()
CC = A%*%b
t2 <- Sys.time()

time_vec = t2 - t1


# Using for-loop

t3 <- Sys.time()
for (i in 1:n) {
  for (j in 1:n) {
    C[i] <- C[i] + A[i, j]*b[j]
  }
}
t4 <- Sys.time()

time_loop = t4 - t3


norm <- norm(CC-C)

speed_up <- as.double(time_loop, units='secs')/as.double(time_vec, units='secs')

n
norm
speed_up

