source: https://bioconductor.org/packages/release/bioc/vignettes/GenomeInfoDb/inst/doc/GenomeInfoDb.pdf

#### Functions
- `genomeStyles`: lists out for each organism, the seqlevelsStyles and their mappings.
- `extractSeqlevels`: extract the desired seqlevelsStyle from a given organism.
```r
extractSeqlevels(species="Arabidopsis_thaliana", style="NCBI")
## [1] "1" "2" "3" "4" "5" "MT" "Pltd"
```
- `extractSeqlevelsByGroup`: extract the desired seqlevelsStyle from a given organism based on a group. (`"auto"`: autosomes; `"sex"`, sex chrosomes; `"circular"`, circular chrosomes, MT and plastid genomes for example; default, all chromosomes)
- `seqlevelsStyle`: the seqname Style for a given character vector.
- `seqlevelsInGroup`: subset a given character vector containing seqnames.
```r
newchr <- paste0("chr",c(1:22,"X","Y","M","1_gl000192_random","4_ctg9_hap1"))
seqlevelsInGroup(newchr, group="sex")
## [1] "chrX" "chrY"
```
- `orderSeqlevels`: return the order of a given character vector which contains seqnames.
- `rankSeqlevels` can return the rank of a given character vector which contains seqnames.
- `mapSeqlevels`: returns a matrix with 1 column per supplied sequence name and 1 row per sequence renaming
map compatible with the specified style. If best.only is TRUE (the default), only the "best"
renaming maps (i.e. the rows with less NAs) are returned as a named character vector.
```r
mapSeqlevels(c("chrII", "chrIII", "chrM"), "NCBI")
## chrII chrIII chrM
## "II" "III" "MT"
```
- `renameSeqlevels`: As the first argument - it takes the object whose seqlevels we need to change, and as the
second argument it takes a named vector which has the changes (can be created with `mapSeqlevels`).
```r
gr <- GRanges(paste0("ch",1:35), IRanges(1:35, width=5))

newnames <- paste0("chr",1:35)
names(newnames) <- paste0("ch",1:35)
head(newnames)
## ch1 ch2 ch3 ch4 ch5 ch6
## "chr1" "chr2" "chr3" "chr4" "chr5" "chr6"
gr <- renameSeqlevels(gr,newnames)
gr
## GRanges object with 35 ranges and 0 metadata columns:
## seqnames ranges strand
## <Rle> <IRanges> <Rle>
## [1] chr1 1-5 *
## [2] chr2 2-6 *
## ...
## [34] chr34 34-38 *
## [35] chr35 35-39 *
## -------
## seqinfo: 35 sequences from an unspecified genome; no seqlengths
```
- `dropSeqlevels`: Here the second argument is the seqlevels that you want to drop. Because these seqlevels are
in use (i.e. have ranges on them), the ranges on these sequences need to be removed before
the seqlevels can be dropped. We call this pruning. The pruning.mode argument controls
how to prune gr. Unlike for list-like objects (e.g. GRangesList) for which pruning can be
done in various ways, pruning a GRanges object is straightforward and achieved by specifying
pruning.mode="coarse".
```r
dropSeqlevels(gr, paste0("chr",23:35), pruning.mode="coarse")
## GRanges object with 22 ranges and 0 metadata columns:
## seqnames ranges strand
## <Rle> <IRanges> <Rle>
## [1] chr1 1-5 *
## [2] chr2 2-6 *
## [3] chr3 3-7 *
6
An Introduction to GenomeInfoDb
## [4] chr4 4-8 *
## [5] chr5 5-9 *
## ... ... ... ...
## [21] chr21 21-25 *
## [22] chr22 22-26 *
## -------
## seqinfo: 22 sequences from an unspecified genome; no seqlengths
```
- `keepSeqlevels`: the second argument is the seqlevels that you want to keep. The follow command gives the same output as the above one.
```r
keepSeqlevels(gr, paste0("chr",1:22), pruning.mode="coarse")
```
- `keepStandardChromosomes`: uses the pre-defined tables inside GenomeInfoDb to find the correct seqlevels according to the sequence style of the object. (`keepStandardChromosomes(gr, pruning.mode="coarse")`)
- Classes inside GenomeInfoDb package: `"GenomeDescription"`, `"Seqinfo"`.

#### Example: converting styles and removing unwanted seqlevels
```r
sequence <- seqlevels(x)
## sequence is in UCSC format and we want NCBI style
newStyle <- mapSeqlevels(sequence,"NCBI")
newStyle <- newStyle[complete.cases(newStyle)] # removing NA cases.
## rename the seqlevels
x <- renameSeqlevels(x,newStyle)
## keep only the seqlevels you want (say autosomes)
auto <- extractSeqlevelsByGroup(species="Homo sapiens", style="NCBI", group="auto")
x <- keepSeqlevels(x,auto)
```
