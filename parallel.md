### how to make mclapply with random sampling reproducible?
```
library(parallel)
RNGkind("L'Ecuyer-CMRG")
set.seed(1243)
mclapply(1:3, function(i) sample(letters, 1), mc.cores = 3)
mclapply(1:3, function(i) sample(letters, 1), mc.cores = 3)
```
