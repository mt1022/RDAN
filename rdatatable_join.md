---
title: "R Notebook"
output: html_notebook
---

### General syntax of join (merge) in data.table

#### Option A: `merge`
`merge` for `data.table` is very similar to `base::merge` for `data.frame`.

#### Option B: `[.data.table`
The general form of syntax for joining two data.table is:
```
    DT[ i,  j,  on ] # + extra arguments
        |   |   |
        |   |    -------> join on which columns?
        |    -------> what to do?
         ---> another data.table to be joined
```
We place another `data.table` at the `i` position as the rows to be joined depends on this `data.table`;
`on` argument is very similar to `by` in the merge (don't confuse it with the `by` in `[.data.table`, which
is more similar to `dplyr::group_by` or right-hand side of `~` in `aggregate`);
`j` position can used to updated the original `DT` or do some other operations and is not used for most cases.

`on` argument can be specified in diverse ways:

>indicate which columns in x should be joined with which columns in i along with the type of binary operator to join with (see non-equi joins below on this). When specified, this overrides the keys set on x and i. There are multiple ways of specifying the on argument:
>
> - As an unnamed character vector, e.g., X[Y, on=c("a", "b")], used when columns a and b are common to both X and Y.
> - Foreign key joins: As a named character vector when the join columns have different names in X and Y. For example, X[Y, on=c(x1="y1", x2="y2")] joins X and Y by matching columns x1 and x2 in X with columns y1 and y2 in Y, respectively.
From v1.9.8, you can also express foreign key joins using the binary operator ==, e.g. X[Y, on=c("x1==y1", "x2==y2")].
NB: shorthand like X[Y, on=c("a", V2="b")] is also possible if, e.g., column "a" is common between the two tables.
> - For convenience during interactive scenarios, it is also possible to use .() syntax as X[Y, on=.(a, b)].
> - From v1.9.8, (non-equi) joins using binary operators >=, >, <=, < are also possible, e.g., X[Y, on=c("x>=a", "y<=b")], or for interactive use as X[Y, on=.(x>=a, y<=b)].

Here are some example from manual:
```r
library(data.table)
DT = data.table(x=rep(c("b","a","c"),each=3), y=c(1,3,6), v=1:9)
DT

X = data.table(x=c("c","b"), v=8:7, foo=c(4,2))
X

DT[X, on="x"]                         # right join
X[DT, on="x"]                         # left join
DT[X, on="x", nomatch=0]              # inner join
DT[!X, on="x"]                        # not join
DT[X, on=c(y="v")]                    # join using column "y" of DT with column "v" of X
DT[X, on="y==v"]                      # same as above (v1.9.8+)

DT[X, on=.(y<=foo)]                   # NEW non-equi join (v1.9.8+)
DT[X, on="y<=foo"]                    # same as above
DT[X, on=c("y<=foo")]                 # same as above
DT[X, on=.(y>=foo)]                   # NEW non-equi join (v1.9.8+)
DT[X, on=.(x, y<=foo)]                # NEW non-equi join (v1.9.8+)
DT[X, .(x,y,x.y,v), on=.(x, y>=foo)]  # Select x's join columns as well

DT[X, on="x", mult="first"]           # first row of each group
DT[X, on="x", mult="last"]            # last row of each group
DT[X, sum(v), by=.EACHI, on="x"]      # join and eval j for each row in i
DT[X, sum(v)*foo, by=.EACHI, on="x"]  # join inherited scope
DT[X, sum(v)*i.v, by=.EACHI, on="x"]  # 'i,v' refers to X's v column
DT[X, on=.(x, v>=v), sum(y)*foo, by=.EACHI] # NEW non-equi join with by=.EACHI (v1.9.8+)
```

### Other notes

#### Set `allow.cartesian = TRUE` when there are duplicated values in joining columns.
>FALSE prevents joins that would result in more than nrow(x)+nrow(i) rows. This is usually caused by duplicate values in i's join columns, each of which join to the same group in 'x' over and over again: a misspecified join. Usually this was not intended and the join needs to be changed. The word 'cartesian' is used loosely in this context. The traditional cartesian join is (deliberately) difficult to achieve in data.table: where every row in i joins to every row in x (a nrow(x)*nrow(i) row result). 'cartesian' is just meant in a 'large multiplicative' sense.

#### `foverlops`
A non-equi join similar to that in `IRanges`. Used for genomic interval analysis.
