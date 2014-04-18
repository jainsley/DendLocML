#setwd("C:/Users/jainsl01/Copy/R_Code/Projects/DendLocML")
setwd("~/Copy/R_Code/Projects/DendLocML")

library("biomaRt")

#Set up mart
ensembl <- useMart("ensembl",dataset="mmusculus_gene_ensembl")
ensembl_genes <- getBM(attributes = "ensembl_gene_id", mart = ensembl)

#Read in attributes to use
attributes <- read.csv('output_rows.csv', stringsAsFactors = FALSE)

#Get simple attributes
simple.attr <- subset(attributes$Attribute, attributes$RowNum == 2)
genes <- c('ENSMUSG00000024617','ENSMUSG00000033981')

#Function to get biomart data from character vector input
get_mart_data_loop <- function(char.ensembl, char.attribs) {
  library(plyr)
  output <- data.frame(ensembl_gene_id = char.ensembl)
  for (i in char.attribs) {
    attribs <- c('ensembl_gene_id', i)
    temp_output <- getBM(attributes=attribs, filters = 'ensembl_gene_id', values = char.ensembl, mart = ensembl)
    output <- join(output, temp_output, by='ensembl_gene_id')
  }  
  return(output)
}

simple_output <- get_mart_data_loop(genes, simple.attr)
write.csv(simple_output, "simple_output.csv")