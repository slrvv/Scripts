####Make the matrix for the clustered enhancers####

library(data.table)
library(tidyverse)
library(dplyr)
table1 <- read.table("/project/CRUP_scores/CRUP_scores/CRUPmerged/CRUP_enhancers_all_tissues_hg38.bed", header = F, row.names = NULL, sep ="\t")
df <- mutate(table1, x = paste(table1$V1, table1$V2, table1$V3, sep = " "), .keep = "used")
df <- cbind(df, table1$V5)
run_type <- c("Single_ended/Primary_cells","Pair_ended/Primary_cells","Single_ended/Cell_lines","Pair_ended/Cell_lines", "Single_ended/Tissues")
dir <- "/project/CRUP_scores/CRUP_scores/RESULTS"
samplenames <-c()
for (run in run_type){
  path <- paste(dir,run, sep="/")
  bash_comm <- paste("ls", path, sep =" ") 
  sample_vec <- system(bash_comm, intern=T)
  samplenames <- c(samplenames, sample_vec)
}
samplenames <- c("row.names", samplenames)
matrix <- matrix(data = 0,nrow = nrow(df),ncol= length(samplenames))
colnames(matrix) <- samplenames
matrix[,1] <- df$x
colnames(table1)
table2 <- aggregate(.~row.names,data=table1,FUN=sum)
print(nrow(table2))
write.table(table2, "tableCAfinal.txt", sep = "\t", dec = ".", row.names = FALSE, col.names = TRUE)

