library(reshape2)
setwd("~/Copy/R_Code/Projects/DendLocML")


gene_GO <- data.frame("Gene" = c("0610005C13Rik","0610005C13Rik","0610005C13Rik","0610006L08Rik","0610006L08Rik",
                              "0610006L08Rik","0610007P14Rik","0610007P14Rik","0610007P14Rik","0610007P14Rik"),
                   "GO" = c("GO:0003674","GO:0005575","GO:0008150","GO:0003674","GO:0005575",
                              "GO:0008150","GO:0005783","GO:0006629","GO:0006694","GO:0008202"))



#gene_GO <- read.table("/cluster/tufts/jainsl01/DendLocML/gene_GO.mgi", header=F)
colnames(gene_GO) <- c("Gene", "GO")
gene_GO_cast <- dcast(gene_GO, Gene ~ GO)
gene_GO_cast.2 <- gene_GO_cast[-c(1)]
row.names(gene_GO_cast.2) <- gene_GO_cast[,1]
gene_GO_cast.2[!(is.na(gene_GO_cast.2))] <- 1
gene_GO_cast.2[is.na(gene_GO_cast.2)] <- 0

write.table(gene_GO_cast.2, file = "gene_GO_dummy_coded.txt", quote=F)