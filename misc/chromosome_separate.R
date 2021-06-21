####Separate by chromosomes
library(data.table)
library(stringr)
chr <- c("chr1", "chr2", "chr3", "chr4", "chr5", "chr6", "chr7", "chr8", "chr9", "chr10", 
         "chr11", "chr12", "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19", "chr20", "chr21", "chr22", "chrX", "chrY" )

data <- read.table("/project/CRUP_scores/Scripts/tableCA_clusteredenh.txt", sep = "\t", header=T, row.names = NULL)
vec <- data$row.names
length(vec)
print("Imported the data")
print(colnames(data))
print(data[1,])
for(el in chr){
  reg <- str_detect(vec, regex(el, ignore_case = TRUE))
  data_subsetted <- data[reg,]
  namefile <- paste("/project/CRUP_scores/Scripts/CA_tables/tableCA_clustered", el, ".txt", sep="")
  print(colnames(data_subsetted))
  fwrite(data_subsetted, namefile, col.names = T, sep ="\t")
  print(paste("subsetted file saved for", el))
}
