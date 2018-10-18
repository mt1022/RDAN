## equivalents to bedtools
bedtools merge (default behavior): construct `GRanges` -> `reduce`;

## convert Ensembl style chromosome names to UCSC style
[`GenomeInfodb`](http://www.bioconductor.org/packages/release/bioc/vignettes/GenomeInfoDb/inst/doc/GenomeInfoDb.pdf) provides many functions for dealing with `seqevels` and genome styles.
```r
# remove regions in non-standard chroms (GL* and KI*, etc) that cannot be converted to UCSC styles
seqlevels(dmr0, pruning.mode = 'coarse') <- extractSeqlevels('Homo sapiens', 'Ensembl')
# rename seqlevels based on a named character vector created by mapSeqlevels
dmr0 <- renameSeqlevels(dmr0, mapSeqlevels(seqlevels(dmr0), 'UCSC'))
```
