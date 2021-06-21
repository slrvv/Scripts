#### test if the CA table was built correctly######


table1 <- read.table("/project/CRUP_scores/Scripts/tableCAfinal.txt", header = T, row.names = 1)
run_type <- c("Single_ended/Cell_lines","Pair_ended/Cell_lines", "Single_ended/Primary_cells","Pair_ended/Primary_cells", "Single_ended/Tissues")
#run_type <- c("Single_ended/Primary_cells","Pair_ended/Primary_cells","Single_ended/Cell_lines","Pair_ended/Cell_lines", "Single_ended/Tissues")
dir <- "/project/CRUP_scores/CRUP_scores/RESULTS"
file_name <- "1_ENHANCER_PREDICTIONS/singleEnh.bedGraph"
len <- 0L
size_vec <-c()

sample_type <- c(rep("Primary_cells", 8), rep("Cell_lines", 37),rep("Tissues",59))
for (run in run_type){
  path <- paste(dir,run, sep="/")
  bash_comm <- paste("ls", path, sep =" ")
  sample_vec <- system(bash_comm, intern=T)
  for(sample in sample_vec){
    filepath <- paste(path,sample,file_name, sep="/")
    try(len <- length(readLines(filepath)))
    size_vec <- c(size_vec, len)
    len <- 0L
  }


}
names <- colnames(table1)
names <- names[-1]
if(length(size_vec)==length(names)){
  print("Sizes OK")
} else{
  print("Wrong sizes")
  print(length(size_vec))
  print(length(names)-1)
  quit(save="no")
}

for(i in 1:length(names)){
  if(sum(table1[,i] == 1) == size_vec[i]){
    print(paste("OK", names[i] , sep = " "))
  }else{
    print(paste("NOT OK", names[i], sep = " "))
  }
}
