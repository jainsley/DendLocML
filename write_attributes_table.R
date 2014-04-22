setwd("C:/Users/jainsl01/Copy/R_Code/Projects/DendAltSplicing")

library("biomaRt")

#Set up mart
ensembl <- useMart("ensembl",dataset="mmusculus_gene_ensembl")

#listAttributes shows all attributes
attributes <- listAttributes(ensembl)
write.csv(attributes, "ensemblAttributes.csv", row.names = FALSE)
