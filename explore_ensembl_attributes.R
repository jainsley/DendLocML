#setwd("C:/Users/jainsl01/Copy/R_Code/Projects/DendLocML")
setwd("~/Copy/R_Code/Projects/DendLocML")


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


#Functions for screening ensembl attributes
#Function to get mart data for all integers specified simultaneously
get_mart_data <- function(range=0) {
  test_attribs <- attributes[range,1]
  attribs <- c('ensembl_gene_id', test_attribs)
  temp <- getBM(attributes=attribs, filters = 'ensembl_gene_id', values = genes, mart = ensembl)
  print(temp)
}

#get_mart_data(982)

#Function to get mart data for all integers specified one at a time in a loop
get_mart_data_loop <- function(range=0) {
  for (i in range) {
    test_attribs <- attributes[i,1]
    attribs <- c('ensembl_gene_id', test_attribs)
    temp <- getBM(attributes=attribs, filters = 'ensembl_gene_id', values = genes, mart = ensembl)
    print(temp)
    Sys.sleep(2)
  }
}

#get_mart_data_loop(1:6)

#Read in screened ensembl attributes
#library(xlsx)
#all.attributes <- read.xlsx("ensemblAttributes.xlsx", 1)
all.attributes <- read.csv("ensemblAttributes.csv")
screened.attributes <- all.attributes[all.attributes$ML == 'y',]
attrToGet <- as.character(screened.attributes[,1])

#Function to collect the number of output lines for each screened ensembl attribute.
#This is necessary to determine how best to collect the data.
write_mart_data_loop <- function(range=0) {
  output <- data.frame()
  for (i in range) {
    test_attribs <- attrToGet[i]
    attribs <- c('ensembl_gene_id', test_attribs)
    temp <- getBM(attributes=attribs, filters = 'ensembl_gene_id', values = genes, mart = ensembl)
    output[i,1] <- test_attribs
    output[i,2] <- nrow(temp)
    Sys.sleep(1)
  }
  return(output)
}

#output_rows <- write_mart_data_loop(1:length(attrToGet))
#write.csv(output_rows, "output_rows.csv")

#Function to get biomart data from character vector input
get_mart_data_char <- function(char.ensembl, char.attribs) {
  attribs <- c('ensembl_gene_id', char.attribs)
  output <- getBM(attributes=attribs, filters = 'ensembl_gene_id', values = char.ensembl, mart = ensembl)
  return(output)
}

input.attributes <- c("low_complexity", "signal_domain", "transmembrane_domain")
test <- get_mart_data_char(genes, input.attributes)
