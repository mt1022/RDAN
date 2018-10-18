# divide numerical range to intervals as factor --> cut
`right` control which side of the interval is closed;
```R
cut(x$s2, breaks = c(0, 1, 5, 10, 20, Inf), right = F)
```

# write an object in string representation in order to write to file or recreate it;
```R
dput(x1)
structure(c(1.88888888888889, 1.3425, 0.859756097560976, 0.596026490066225
), class = "table", .Dim = 4L, .Dimnames = structure(list(c("1",
"2", "3", "4")), .Names = ""))
```

# stop using `Reduce(cbind, list)`
as cbind and rbind can take multiple arguments, using `do.call` would be more efficients;
```R
length(ll)

f <- function(x, y, z)
# 3

do.call(f, ll) == f(ll[[1]], [[2]], [[3]])
```

## R packages install --> cannot downloaded
```R
library(BiocInstaller)
chooseCRANmirror()
```

## list the size of all objects
```R
for (obj in ls()) { message(obj); print(object.size(get(obj)), units='auto') }
```

## comandline install with R CMD INSTALL
```sh
export R_LIBS="/home/your_username/R_libs"
 R CMD INSTALL -l /home/your_username/R_libs pkg_version.tar.gz
```


## http://www.perfectlyrandom.org/2015/06/16/never-trust-the-row-names-of-a-dataframe-in-R/


## Q: compare with NAs;
```R
> NA > 0.5 & F
[1] FALSE
> NA > 0.5 & T
[1] NA
```

## how to plot multiply symbol 'x':
```R
plot(0)
for(i in 1:4)
    text(1, 0.2*i, bquote( x[.(i)] == .(pnorm(i)) %*% 10^2 ))
```
for a list of plotmatch syntax:
https://stat.ethz.ch/R-manual/R-devel/library/grDevices/html/plotmath.html

## remove useless attributes from object:
```R
# view all attributes of a data.frame:
names(attributes(x))

# keep only first 3 attributes (first 3 are usually name, row.names, class)
attributes(x) <- attributes(x)[1:3]
```

## capture output of print:
```r
niceprint <- function(x) cat(paste0('# ', capture.output(x)), sep = '\n')
```
