---
title: Rmicrobenckmark
date: 2016-10-25
---

## first example
```R
library(microbenchmark)

microbenchmark(
    sample = sample.int(1e8, 1000),
    runif = floor(runif(1000, 1, 1e8)),
    times = 5000
)
# Unit: microseconds
#    expr    min     lq     mean  median     uq      max neval
#  sample 19.339 21.118 23.09125 21.6785 22.254 6563.276  5000
#   runif 30.630 31.105 31.58310 31.5455 31.749   47.702  5000
```
