---
title: statistical tests in R
date: 2016-11-22
---

## ks.test test for difference in distribution, not difference in mean:
for example, two norm distribution with same mean and different sd have different shapes, so that t.test is not significant while ks.test is significant;
```R
ks.test(rnorm(1000, sd = 1), rnorm(1000, sd = 2)) ## significant
t.test(rnorm(1000, sd = 1), rnorm(1000, sd = 2))
```
