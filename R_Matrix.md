## avoid converting sparse matrix into matrix with normal storage, which consumes many more memory and very slow
```r
library(microbenchmark)
library(Matrix)

x <- matrix(rpois(1000 * 1000, 0.1), nrow = 1000)
y <- as(x, 'dgCMatrix')

microbenchmark(
     a = {z <- 2^y - 1},
     b = {
         z <- y
         z@x <- 2^z@x - 1
     }
)
# Unit: microseconds
#  expr      min         lq       mean    median        uq        max neval
#     a 9907.870 17782.9795 41972.4501 26316.664 79718.796 137591.200   100
#     b  829.581   865.1625   948.7881   870.715   891.663   2548.171   100
```
