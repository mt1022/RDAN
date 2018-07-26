


## filter_

```R
filter_rows <- function(data, condition){
    data %>% filter_(.dots = )
}

filter_rows <- function(data, ...){
    f_list(...)
}

filter_rows <- function(data, condition){
    filter_(data, condition)
}

filter_rows(mtcars, quote(wt > 3 & qsec < 20))

filter_rows2 <- function(data, condition1, condition2){
    filter_(data, condition1, condition2)
}

filter_rows2(mtcars, quote(wt > 3), quote(qsec < 20))
```
