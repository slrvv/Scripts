###Matrix for CA unclustered enhancers
library(data.table)
library(plotly)
#run_type <- c("Single_ended/Primary_cells","Pair_ended/Primary_cells","Single_ended/Cell_lines","Pair_ended/Cell_lines", "Single_ended/Tissues")
run_type <- c("Pair_ended/Primary_cells", "Single_ended/Primary_cells")
dir <- "/project/CRUP_scores/CRUP_scores/RESULTS"
file_name <- "1_ENHANCER_PREDICTIONS/singleEnh.bedGraph"
samplenames <-c()
chrpos <-c()
numrows <-c(1)
for (run in run_type){
  path <- paste(dir,run, sep="/")
  bash_comm <- paste("ls", path, sep =" ") 
  sample_vec <- system(bash_comm, intern=T)
  samplenames <- c(samplenames, sample_vec)
  print(samplenames)
  for (sample in sample_vec){
    pathfile <- paste(path, sample, file_name, sep =  "/")
    file <- fread(pathfile, drop = 4)
    numrows <- c(numrows, (numrows[length(numrows)]+nrow(file)))
    data <- transform(file, newcol=paste(file$V1, file$V2, file$V3))
    chrpos <- c(chrpos, data$newcol)
  }
}  
matrix <- matrix(data = 0,nrow = length(chrpos),ncol= length(samplenames))
colnames(matrix) <- samplenames
rownames(matrix) <- chrpos
print(numrows)

start = numrows[1]
for(n in 1:length(samplenames)){
    print("Ronda")
    print(n)
    print(start)
    print(numrows[n+1]-1)
    
    for (i in start:numrows[n+1]-1){
        matrix[i,n] = 1
    }
  start= numrows[n+1]+1
}

write.table(matrix, "tableCA.txt", append = FALSE, sep = " ", dec = ".", row.names = TRUE, col.names = TRUE)
