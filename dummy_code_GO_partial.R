#Dummy coding gene ontology (GO) categories. To be run on Tufts cluster.

library(reshape2)
setwd("/cluster/tufts/jainsl01/DendLocML/")

#Read in genome wide GO data, add column names.
gene_GO <- read.table("./data/gene_GO.mgi", header=F)
colnames(gene_GO) <- c("Gene", "GO")

#Convert to wide format with dcast.
gene_GO_cast <- dcast(gene_GO, Gene ~ GO)

#Move gene names to row names.
gene_GO_cast.2 <- gene_GO_cast[-c(1)]
rownames(gene_GO_cast.2) <- gene_GO_cast[,1]

#Replace any cells containing data with 1 to indicate presence of GO category.
#gene_GO_cast.2[!(is.na(gene_GO_cast.2))] <- 1

#Replace any cells missing data with 0 to indicate absence of GO category.
#gene_GO_cast.2[is.na(gene_GO_cast.2)] <- 0

#Create a new data frame that has the gene name as a data frame column instead of a row name.
gene_GO_dc <- cbind(row.names(gene_GO_cast.2), gene_GO_cast.2)
colnames(gene_GO_dc)[1] <- "Gene"

#Write file
write.table(gene_GO_dc, file = "./data/gene_GO_partial_dummy_coded.txt", quote=F, row.names=F)
