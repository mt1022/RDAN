---
title: Formatting numbers in figures
---
#### Add thousand seperators
This can be done with `format` in base R or more easily with `scales` package.
```r
x <- c(1, 10, 1000, 10000, 100000, 10000000)

scales::comma(x)
# [1] "1"          "10"         "1,000"      "10,000"     "100,000"    "10,000,000"

format(x, big.mark = ',', scientific = FALSE)
# [1] "         1" "        10" "     1,000" "    10,000" "   100,000" "10,000,000"
```
Whitespace produced by `format` can be removed by setting `trim = FALSE`.
```r
format(x, big.mark = ',', scientific = FALSE, trim = TRUE)
# [1] "1"          "10"         "1,000"      "10,000"     "100,000"    "10,000,000"'
```

#### Label P-value in scientific notation
```r
scip <- function(rho, p, m = bquote(P)){
    rho <- sprintf('%.3f', rho)
    if(abs(p) >= 0.1){
        bquote(rho == .(rho) ~ ', ' ~ italic(.(m)) == ~ .(sprintf('%.3f', p)))
    }else if(p == 0){
        bquote(rho == .(rho) ~ ', ' ~ italic(.(m)) < 10^-307)
    }else{
        x <- as.numeric(strsplit(sprintf('%.2e', p), 'e')[[1]])
        bquote(rho == .(rho) ~ ', ' ~ italic(.(m)) == .(x[1]) %*% 10^.(x[2]))
    }
}
```
