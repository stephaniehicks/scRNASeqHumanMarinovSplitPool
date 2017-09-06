##### Summary
# Single GM12878 cells were picked and RNA-seq libraries were 
# generated using the SMART-seq protocol. We also carried out 
# RNA-seq experiments on pools of 10, 30 and 100 cells, on 100pg 
# and 10ng of total RNA, and on pools of 10 cells that were 
# subsequently split into 10 separate sample and processed as if 
# they were single cells in order to assess technical variation in our experiments.

packagePath <- "/net/irizarryfs01/srv/export/irizarryfs01_backed_up/share_root/shicks/dataPackages/scRNASeqHumanMarinovSplitPool"

### Read in phenotypic table
library(GEOquery)
gse <- getGEO("GSE44618")
e <- gse[[1]]
pd <- pData(e)
# write.table(pd, file = file.path(packagePath, "extdata/pdGSE44618.txt"), 
#             quote= FALSE, sep = "\t")

### Create SingleCellExperiment 
# location of FPKM files
dataPath <- "/net/irizarryfs01/srv/export/irizarryfs01/share_root/shicks/GEO/GSE44618"

library(readr)
library(stringr)
library(scater)
pd <- read.delim(file.path(packagePath, "extdata/pdGSE44618.txt"), sep="\t", header = TRUE)

loadFiles <- list.files(dataPath)
loadFiles <- loadFiles[grep("fpkm", loadFiles)]
esetNorm = array(0, dim = c(55040, length(loadFiles)))

for(i in 1:length(loadFiles)){
  dat <- read_delim(file.path(dataPath, loadFiles[i]), 
                    col_names = TRUE, delim = "\t",
                    col_types = cols("c", "c", "c", "c", "c", "c", "c", "c", "c", "n", "n", "n", "c"))
  if(i == 1){
   esetNormHeader <- data.frame("gene_id" = dat$gene_id, "symbol" = dat$gene_short_name,
                                "tss_id" = dat$tss_id, "locus" = dat$locus)
  }
  esetNorm[,i] <- dat$FPKM
}
esetNormHeader$symbol <- as.character(esetNormHeader$symbol) 

colnames(esetNorm) <- str_sub(loadFiles, start = 1, end = 10)
rownames(esetNorm) <- esetNormHeader$symbol
pd <- pd[match(colnames(esetNorm), pd$geo_accession), ]


# Create SingleCellExperiment
sce <- SingleCellExperiment(assays = list(exprs=esetNorm),
                            rowData=esetNormHeader, colData=pd)
# Save SingleCellExperiment
save(sce, file=file.path(packagePath, "data/sce_marinov.rda"))


