#!/usr/bin/env Rscript

# Problem1:Root-finding Numerical Experiment

library(doParallel)
library(parallel)
library(pracma)

n <- 4^9

f <- function(x) {
    return(sin(3 * pi * cos(2 * pi * x) * sin(pi * x)))
}


## Normal Computation (Computing t1)

start_time <- Sys.time()
result_1 <- foreach(i = 1:n) %do% fzero(f, i)
t1 <- Sys.time() - start_time


## Embarrasingly Parallel Computation (Computing tp)

my_cluster <- makeCluster(detectCores(), type = "PSOCK")
registerDoParallel(my_cluster)


start_time_2 <- Sys.time()
# result2 <- parallel::mclapply(1:n, function(x) fzero(root, x)) # nolint
result_2 <- foreach(i = 1:n, .packages = c("pracma")) %dopar% fzero(f, i)
tp <- Sys.time() - start_time_2

stopCluster(my_cluster)


## Printing results

speedup <- as.double(t1) / as.double(tp)
efficiency <- (speedup / detectCores()) * 100

sprintf("t1: %f", t1)
sprintf("tp: %f", tp)
sprintf("Speedup: %f", speedup)
sprintf("Average Efficiency: %f", efficiency)
