#### Relationship between eigen value decomposition, SVD, and PCA
```r
library(data.table)

iris <- as.data.table(iris)
iris <- iris[, .(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)]


# PCA of iris data
pca <- prcomp(iris)

# SVD
m <- t(iris)
X <- m - rowMeans(m)
X.svd <- svd(X)

# X.svd$u is the eigen value of covariance matrix
Y <- t(X)/sqrt(ncol(m))   # Y <= X'/sqrt(n)
covX <- t(Y) %*% Y  # Y'*Y = XX'/n, i.e. the covariance matrix
eigen(covX)

# PCA sdev = sqrt(sum of squares)(i.e., svd$d) / sqrt(n-1)
print(X.svd$d/sqrt(nrow(iris) -1))
print(pca$sdev)

# pca$rotation == eigen(covX) == X.svd$u
eigen(covX)$vectors
pca$rotation
X.svd$u

# svd: X = U Sigma V' -> U' X = Sigma V'
# t(pca$x) = U' X = Sigma V'
# t(pca$x) == diag(X.svd$d) %*% t(X.svd$v)  # i.e. \Sigma %*% \V^T
#          == \U^T %*% X
t(pca$x)
diag(X.svd$d) %*% t(X.svd$v)
t(X.svd$u) %*% X
t(eigen(covX)$vectors) %*% X


# variance explained by each PC
tmp <- pca$sdev^2 * (nrow(iris) - 1)
diag(cov(pca$x)) * (nrow(iris) - 1)
X.svd$d^2   # square of sigular value is eigen value of XX'

# fraction of variance explained by each PC
tmp/sum(tmp)
diag(cov(pca$x)) / sum(diag(cov(pca$x)))
```
