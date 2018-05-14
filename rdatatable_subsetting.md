---
title: subsetting rows or columns in data.table
---

##### Make an example `data.table`
```r
library(data.table)
DT <- data.table(x = 1:3, y = 2:4, m = letters[1:3], z = LETTERS[1:3])
DT
#>    x y m z
#> 1: 1 2 a A
#> 2: 2 3 b B
#> 3: 3 4 c C
```

#### subset rows
```r
DT[1]  # first row
#>    x y m z
#> 1: 1 2 a A
DT[c(1, 3)]  # first and third row
#>    x y m z
#> 1: 1 2 a A
#> 2: 3 4 c C
DT[x >= 2]  # rows where column x >= 2
#>    x y m z
#> 1: 2 3 b B
#> 2: 3 4 c C
```

#### subset columns
```r
DT[, 1]  # first col
#>    x
#> 1: 1
#> 2: 2
#> 3: 3
DT[, 'x']  # same
#>    x
#> 1: 1
#> 2: 2
#> 3: 3
DT[, c(1, 3)]  # first and third cols
#>    x m
#> 1: 1 a
#> 2: 2 b
#> 3: 3 c
DT[, c('x', 'm')]  # same
#>    x m
#> 1: 1 a
#> 2: 2 b
#> 3: 3 c
x <- c('x', 'm')
DT[, x]  # just retrieve the value of column `x`
#> [1] 1 2 3
DT[, ..x]  # now it understands that x is a vector of column names
#>    x m
#> 1: 1 a
#> 2: 2 b
#> 3: 3 c
DT[, x, with = FALSE]  # force data.frame like behaviors
#>    x m
#> 1: 1 a
#> 2: 2 b
#> 3: 3 c
x <- c(1, 3)
DT[, ..x]  # treat x as a  vector of column indices
#>    x m
#> 1: 1 a
#> 2: 2 b
#> 3: 3 c
```
