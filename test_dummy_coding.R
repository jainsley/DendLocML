#Test of dummy coding gene ontology(GO) categories using cast function from reshape2 package.

library(reshape2)
setwd("~/Copy/R_Code/Projects/DendLocML")

#Create test data frame, add column names
gene_GO <- data.frame("Gene" = c("0610005C13Rik","0610005C13Rik","0610005C13Rik","0610006L08Rik","0610006L08Rik",
                              "0610006L08Rik","0610007P14Rik","0610007P14Rik","0610007P14Rik","0610007P14Rik"),
                   "GO" = c("GO:0003674","GO:0005575","GO:0008150","GO:0003674","GO:0005575",
                              "GO:0008150","GO:0005783","GO:0006629","GO:0006694","GO:0008202"))
colnames(gene_GO) <- c("Gene", "GO")

#Convert to wide format with dcast.
gene_GO_cast <- dcast(gene_GO, Gene ~ GO)

#Move gene names to row names.
gene_GO_cast.2 <- gene_GO_cast[-c(1)]
rownames(gene_GO_cast.2) <- gene_GO_cast[,1]

#Replace any cells containing data with 1 to indicate presence of GO category.
gene_GO_cast.2[!(is.na(gene_GO_cast.2))] <- 1

#Replace any cells missing data with 0 to indicate absence of GO category.
gene_GO_cast.2[is.na(gene_GO_cast.2)] <- 0

#Create a new data frame that has the gene name as a data frame column instead of a row name.
gene_GO_dc <- cbind(row.names(gene_GO_cast.2), gene_GO_cast.2)
colnames(gene_GO_dc)[1] <- "Gene"

#Write file
write.table(gene_GO_dc, file = "gene_GO_dummy_coded.txt", quote=F, row.names=F)
