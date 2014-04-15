setwd("C:/Users/jainsl01/Copy/R_Code/Projects/DendLocML")

library("biomaRt")

#Set up mart
ensembl <- useMart("ensembl",dataset="mmusculus_gene_ensembl")

#Test data mining
attributes <- read.csv('ensemblAttributes.csv', stringsAsFactors = FALSE)
genes <- c('ENSMUSG00000024617','ENSMUSG00000033981')
#ENSMUSG00000024617 = Camk2a
#ENSMUSG00000033981 = Gria2

###################################################################
# The following commands run simultaneously would give the following error:
#
# test_attribs <- attributes[45:49,1]
# attribs <- c('ensembl_gene_id', 'mgi_symbol', test_attribs)
# getBM(attributes=attribs, filters = 'ensembl_gene_id', values = genes, mart = ensembl)
#
# Error in getBM(attributes = attribs, filters = "ensembl_gene_id", values = genes,  : 
# Query ERROR: caught BioMart::Exception::Usage: Too many attributes selected for External References
#
# Putting the commands in a for loop so that they were queried one at a time works.
###################################################################

get_mart_data <- function(range=0) {
  for (i in range) {
    test_attribs <- attributes[i,1]
    attribs <- c('ensembl_gene_id', test_attribs)
    temp <- getBM(attributes=attribs, filters = 'ensembl_gene_id', values = genes, mart = ensembl)
    print(temp)
    Sys.sleep(2)
  }
}

get_mart_data(1:10)
