### Extract the entrez gene ID for a vector of ensembl gene IDs
```r
library(biomaRt)
ensembl <- useMart(
    'ensembl',  # the mart to be connected
    dataset = 'hsapiens_gene_ensembl',
    host = 'http://asia.ensembl.org')

entrez_gene <- getBM(
    attributes = c('ensembl_gene_id', 'entrezgene'),
    filters = 'ensembl_gene_id',
    values = ensembl_gene_ids,
    mart = ensembl)
```
