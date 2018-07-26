## import bigwig files and extract coverage in a Grange obj;
- import as `RLeList`:
```R
bw.files.list <- BigWigFileList(bw.files)
lapply(bw.files.list, function(bw){
    bw.rle <- import(bw, as = 'RleList')[[chrm]]
    as.vector(Views(bw.rle, ranges(g.intv))[[1]])
})
```
- import selected region:
```R
sapply(bw.files.list, function(bw){
    bw <- import(bw, which = g.intv)
    bw.cov <- coverage(keepSeqlevels(bw, chrm), weight = 'score')
    as.vector(Views(bw.cov[[1]], ranges(g.intv))[[1]])
})
```

## convert Rle-factor to character
```R
# try
as.character(seqnames(g.intv)[1])
# isntread of
as.character(runValue(seqnames(g.intv))[1])
```
