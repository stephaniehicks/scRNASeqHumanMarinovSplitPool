# scRNASeqHumanMarinovSplitPool

This package contains a Bioconductor 
    [`SingleCellExperiment`](https://bioconductor.org/packages/devel/bioc/html/SingleCellExperiment.html) from Marinov et al. (2014) paper 
    that performed a pool/split experiment of single cell and 
    bulk cell experiments from GM12878 cell line ([PMID: 24299736](https://www.ncbi.nlm.nih.gov/pubmed/24299736)). 
    Metadata and pre-processed data (FPKM) were downloaded
    from Gene Expression Omnibus ([GSE44618](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE44618)). 
    
# Installation

The R-package **scRNASeqHumanMarinovSplitPool** can be installed from Github using the R
package **devtools**.
```s
library(devtools)
install_github("stephaniehicks/scRNASeqHumanMarinovSplitPool")
```

# Load data

The data is provided as a `SingleCellExperiment` object can be loaded 
by running the following code in R: 

```r
library(scRNASeqHumanMarinovSplitPool)
data(sce_marinov)

assay(sce) # FPKMs
colData(sce) # phenotypic information
rowData(sce) # gene-level information
```

# Bug reports
Report bugs as issues on the [GitHub repository](https://github.com/stephaniehicks/scRNASeqHumanMarinovSplitPool)

# Contributors

* [Stephanie Hicks](https://github.com/stephaniehicks)