library(pracma)

n <- 10000
a <- runif(n)
b <- runif(n)
c <- 0


# Dot product with vectorization
t1 <- Sys.time()
cc <- a%*%b
t2 <- Sys.time()

time_vec = t2 - t1

# Dot product with for-loop
t3 <- Sys.time()
for (i in 1:n) {
  c <- c + a[i]*b[i]
}
t4 <- Sys.time()
c
time_loop = t4 - t3

norm <- (cc-c)

speed_up <- as.double(time_loop, units='secs')/as.double(time_vec, units='secs')

n
norm
speed_up
