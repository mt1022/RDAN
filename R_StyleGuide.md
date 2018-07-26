## for code that are run only once and not need to be run later (for example, produce tmp files for expternal programs), put it in a Not run block:
```R
## Not run: generate TSS bed for liftover
dbtss.site.bed <- lapply(top.dbtss[c('HEK293', 'HeLa', 'PC3')], function(x){
    x[, .(
        chrom = chrom,
        start = tss.start,
        end = tss.end,
        gene, shift, strand
    )]
})
dbtss.site.bed <- rbindlist(dbtss.site.bed, idcol = 'cell.line')
dbtss.site.bed[, gene := paste0(gene, '_', cell.line)]
dbtss.site.bed[, cell.line := NULL]
fwrite(dbtss.site.bed, file = 'Rtmp_dbTSS_all_site.bed', sep = '\t', col.names = FALSE)
## End(Not run)
```
