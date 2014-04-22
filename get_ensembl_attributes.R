#setwd("C:/Users/jainsl01/Copy/R_Code/Projects/DendLocML")
#setwd("~/Copy/R_Code/Projects/DendLocML")
setwd("/cluster/tufts/jainsl01/DendLocML")

library("biomaRt")

#Set up mart
ensembl <- useMart("ensembl",dataset="mmusculus_gene_ensembl")
ensembl_genes <- getBM(attributes = "ensembl_gene_id", mart = ensembl)

#Read in attributes to use
attributes <- read.csv('./data/output_rows.csv', stringsAsFactors = FALSE)

#Get simple attributes
simple.attr <- subset(attributes$Attribute, attributes$RowNum == 2)

filenames <- list.files("./data", pattern="*.csv", full.names=FALSE)
collected_data <- gsub(".csv", "", filenames)

uncollected_data <- subset(simple.attr, !(simple.attr %in% collected_data))

#Function to get biomart data from character vector input
get_mart_data_loop <- function(char.ensembl, char.attribs) {
  library(plyr)
  output <- data.frame(ensembl_gene_id = char.ensembl)
  for (i in char.attribs) {
    attribs <- c('ensembl_gene_id', i)
    temp_output <- getBM(attributes=attribs, filters = 'ensembl_gene_id', values = char.ensembl, mart = ensembl)
    #output <- join(output, temp_output, by='ensembl_gene_id')
    write.csv(temp_output, paste0("./data/",i,".csv"), quote=FALSE)
    Sys.sleep(1)
  }  
  #return(output)
}

print(uncollected_data)

#simple_output <- get_mart_data_loop(ensembl_genes, simple.attr)
#write.csv(simple_output, "./data/simple_output.csv")
