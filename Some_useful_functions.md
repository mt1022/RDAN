---
title: "some useful functions"
---

### `sweep`
`sweep` can be used to apply arithmatics between a vector and each row or each column of a matrix:
```r
set.seed(3)
x <- matrix(rnorm(20), nrow = 4)

# extract row-wise mean from each row:
sweep(x, 1, rowMeans(x), '-')
x - rowMeans(x)  # use the automatic recycling

# extract column-wise mean from each column:
sweep(x, 2, colMeans(x), '-')
```
