### an integer programming example
Given integers x, y and z, minize `x + y + z` as long as `1600x + 750y + 300z = 59900`.
```R
library(lpSolveAPI)

lprec <- make.lp(0, 3)
set.objfn(lprec, c(1, 1, 1))
set.type(lprec, 1:3, type = 'integer')

add.constraint(lprec, c(1, 0, 0), '>=', 0)
add.constraint(lprec, c(0, 1, 0), '>=', 0)
add.constraint(lprec, c(0, 0, 1), '>=', 0)
add.constraint(lprec, c(1600, 750, 300), '=', 59900)

solve(lprec)
get.objective(lprec)
get.variables(lprec)
```
