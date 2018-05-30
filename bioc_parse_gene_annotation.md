---
tittle: Parse gene annotataion files
---

#### how to parse GTF/GFF3?
`GenomicFeatures::makeTxDbFromGFF` automatically parse both GTF and GFF3 files, compressed or uncompressed.

example:
```r
library(GenomicFeatures)
txdb <- makeTxDbFromGFF('~/database/flybase/dmel_r6.21_FB2018_02/dmel-all-r6.21.gtf.gz')
```
Note that `GenomicFeatures::makeTxDbFromGFF` only keeps those informations required to build txdb, some information such as gene symbols might get ignored. To reserve all the informations, try `rtracklayer::import`, which will import as `Granges` object. All the meta informations will be present in metadata columns and can be extracted with `mcols`:
```r
x <- rtracklayer::import('~/database/flybase/dmel_r6.21_FB2018_02/dmel-all-r6.21.gtf.gz', 'gtf')
# > mcols(x)
# DataFrame with 542030 rows and 9 columns
#          source        type     score     phase     gene_id gene_symbol transcript_id transcript_symbol           #
#        <factor>    <factor> <numeric> <integer> <character> <character>   <character>       <character> <character>
# 1       FlyBase        gene        NA        NA FBgn0031081        Nep3            NA                NA          NA
# 2       FlyBase        mRNA        NA        NA FBgn0031081        Nep3   FBtr0070000           Nep3-RA          NA
# 3       FlyBase        5UTR        NA        NA FBgn0031081        Nep3   FBtr0070000           Nep3-RA          NA
# 4       FlyBase        exon        NA        NA FBgn0031081        Nep3   FBtr0070000           Nep3-RA          NA
# 5       FlyBase        exon        NA        NA FBgn0031081        Nep3   FBtr0070000           Nep3-RA          NA
# ...         ...         ...       ...       ...         ...         ...           ...               ...         ...
# 542026  FlyBase start_codon        NA         0 FBgn0031279      CG3544   FBtr0331652         CG3544-RB          NA
# 542027  FlyBase         CDS        NA         0 FBgn0031279      CG3544   FBtr0331652         CG3544-RB          NA
# 542028  FlyBase  stop_codon        NA         0 FBgn0031279      CG3544   FBtr0331652         CG3544-RB          NA
# 542029  FlyBase        3UTR        NA        NA FBgn0031279      CG3544   FBtr0331652         CG3544-RB          NA
# 542030  FlyBase        3UTR        NA        NA FBgn0031279      CG3544   FBtr0331652         CG3544-RB          NA
```

### how to extract info from a `txdb`?
read the manual `` ?`select,TxDb-method` ``:
> `keytypes(x)`: allows the user to discover which keytypes can be passed in to select or keys and the keytype argument.

> `keys(x, keytype, pattern, column, fuzzy)`: Return keys for the database contained in the TxDb object .

> `columns(x)`: Show which kinds of data can be returned for the `TxDb` object.

> `select(x, keys, columns, keytype)`: When all the appropriate arguments are specified select will retrieve the matching data as a `data.frame` based on parameters for selected keys and columns and `keytype` arguments.

#### how to get the length of each transcripts in GTF?
> The `transcriptLengths` function extracts the transcript lengths from a TxDb object. It also returns the CDS and UTR lengths for each transcript if the user requests them.

```r
transcriptLengths(txdb, with.cds_len = TRUE, with.utr5_len = TRUE, with.utr3_len = TRUE)

#   tx_id     tx_name     gene_id nexon tx_len cds_len utr5_len utr3_len
# 1     1 FBtr0300689 FBgn0031208     2   1880     855      151      874
# 2     2 FBtr0300690 FBgn0031208     3   1802    1443      151      208
# 3     3 FBtr0330654 FBgn0031208     2   1844     819      151      874
# 4     4 FBtr0309810 FBgn0263584     2   2230       0        0        0
# 5     5 FBtr0347585 FBgn0267987     1    951       0        0        0
# 6     6 FBtr0345732 FBgn0266878     1    244       0        0        0
# ...
```
note, the cds_len/utr5_len/utr3_len will be 0 if not present (example, for ncRNAs).

#### a convenient function to extract gene info from gtf:
```r
library(GenomicFeatures)
library(rtracklayer)
extractGeneInfo <- function(gtf.path){
    txdb <- makeTxDbFromGFF(gtf.path)

    txlen <- transcriptLengths(txdb, with.cds_len = TRUE, with.utr5_len = TRUE, with.utr3_len = TRUE)
    txtype <- select(txdb, keys = keys(txdb, 'TXNAME'), columns = c('TXTYPE'), keytype = c('TXNAME'))
    names(txtype) <- c('tx_name', 'tx_type')
    x <- rtracklayer::import(gtf.path, 'gtf')
    genesymbol <- unique(as.data.frame(mcols(x))[c('gene_id', 'gene_symbol')])

    merge(merge(txlen, txtype, by = 'tx_name'), genesymbol, by = 'gene_id')
}
```
