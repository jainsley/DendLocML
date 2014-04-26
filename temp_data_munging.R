#Read in homolog csv filenames
filenames <- list.files("./data", pattern="*homolog*.csv", full.names=TRUE)

#Merge dataframes in a list
ldf <- lapply(filenames, read.csv)
bigdf <- merge_all(ldf)
write.csv(bigdf, "./output_data/bigdf.1to20.csv")

collected_data <- gsub(".csv", "", filenames)

uncollected_data <- subset(simple.attr, !(simple.attr %in% collected_data))


#Function to read in biomart data and merge them based on gene name
merge_mart_data <- function(char.ensembl, char.attribs) {
  output <- data.frame(ensembl_gene_id = char.ensembl)
  for (i in char.attribs) {
    temp_output <- read.csv(paste0("./data/",i))
    output <- join(output, temp_output, by='ensembl_gene_id')
    output <- merge(output, temp_output, by='ensembl_gene_id')
  }
  return(output)
}

merged_data <- merge_mart_data(ensembl_genes[,1], filenames)

write.csv(merged_data, "./output_data/merged_data.csv")

merge_mart_data <- function(input_files) {
  ldf <- lapply(input_files, read.csv)
  mdf <- ldf[[1]]
  for (df in ldf) {
    mdf <- left_join(mdf, df, by = 'ensembl_gene_id')
  }
  return(mdf)
}

merged_1to20 <- merge_mart_data(filenames[1:20])
write.csv(merged_1to20, "./output_data/mdf1to20.csv")
rm(merged_1to20)

merged_21to40 <- merge_mart_data(filenames[21:40])
write.csv(merged_21to40, "./output_data/mdf21to40.csv")
rm(merged_21to40)

merged_41to60 <- merge_mart_data(filenames[41:60])
write.csv(merged_41to60, "./output_data/mdf41to60.csv")
rm(merged_41to60)

merged_61to80 <- merge_mart_data(filenames[61:80])
write.csv(merged_61to80, "./output_data/mdf61to80.csv")
rm(merged_61to80)

merged_81to100 <- merge_mart_data(filenames[81:100])
write.csv(merged_81to100, "./output_data/mdf81to100.csv")
rm(merged_81to100)

merged_101to120 <- merge_mart_data(filenames[101:120])
write.csv(merged_101to120, "./output_data/mdf101to120.csv")
rm(merged_101to120)

merged_121to136 <- merge_mart_data(filenames[121:136])
write.csv(merged_121to136, "./output_data/mdf121to136.csv")
rm(merged_121to136)

filenames <- list.files("./output_data", pattern="mdf*.csv", full.names=TRUE)

aggregate_mart_data <- function(input_files) {
  ldf <- lapply(input_files, function(i){read.csv(i, header=TRUE, stringsAsFactors=FALSE)})
  for (df in ldf) {
    adf <- aggregate(df, by = list(df$ensembl_gene_id), max)
  }
  return(adf)
}


for (i in filenames) {
  df <- read.csv(i, stringsAsFactors = FALSE)
  agg <- aggregate(df, by=list(df$ensembl_gene_id), max)
  write.csv(agg, gsub("mdf","adf",i))
}