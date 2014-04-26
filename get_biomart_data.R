#setwd("C:/Users/jainsl01/Copy/R_Code/Projects/DendLocML")
#setwd("~/Copy/R_Code/Projects/DendLocML")
setwd("/cluster/tufts/jainsl01/DendLocML")

library("biomaRt")

rm(list = ls())

#Set up mart
ensembl <- useMart("ensembl",dataset="mmusculus_gene_ensembl")
#ensembl_genes <- getBM(attributes = "ensembl_gene_id", mart = ensembl)
#write.csv(ensembl_genes, "./data/ensembl_genes.txt", quote=FALSE, row.names=FALSE, col.names=FALSE)

#Read in ensembl gene names
ensembl_genes <- read.table("./data/ensembl_genes.txt", header=TRUE, stringsAsFactors = FALSE)

#Read in attributes to use
attributes <- read.csv('./data/output_rows', stringsAsFactors = FALSE)

#Get simple attributes
simple.attr <- subset(attributes$Attribute, attributes$RowNum == 2)

#Function to get biomart data from character vector input
get_mart_data_loop <- function(char.ensembl, char.attribs) {
  for (i in char.attribs) {
    attribs <- c('ensembl_gene_id', i)
    temp_output <- getBM(attributes=attribs, filters = 'ensembl_gene_id', values = char.ensembl, mart = ensembl)
    write.csv(temp_output, paste0("./data/",i,".csv"), quote=FALSE)
    Sys.sleep(1)
  }
}

get_mart_data_loop(ensembl_genes[,1], attributes$Attribute)
