##Checking number of enhancers per sample
library(ggplot2)
library("scales")
run_type <- c("Single_ended/Cell_lines","Pair_ended/Cell_lines", "Single_ended/Primary_cells","Pair_ended/Primary_cells", "Single_ended/Tissues")
#run_type <- c("Single_ended/Primary_cells","Pair_ended/Primary_cells","Single_ended/Cell_lines","Pair_ended/Cell_lines", "Single_ended/Tissues")
dir <- "/project/CRUP_scores/CRUP_scores/RESULTS"
file_name <- "1_ENHANCER_PREDICTIONS/singleEnh.bedGraph"
len <- 0L
size_vec <-c()
name_vec <- c()
sample_type <- c(rep("Primary_cells", 8), rep("Cell_lines", 37),rep("Tissues",59))
for (run in run_type){
  path <- paste(dir,run, sep="/")
  bash_comm <- paste("ls", path, sep =" ")
  sample_vec <- system(bash_comm, intern=T)
  for(sample in sample_vec){
    name_vec <- c(name_vec, sample)
    filepath <- paste(path,sample,file_name, sep="/")
    try(len <- length(readLines(filepath)))
    size_vec <- c(size_vec, len)
    len <- 0L
  }
  

} 
print(length(size_vec))
print(size_vec)
print(name_vec)
df <- data.frame(name_vec, size_vec,sample_type)
df
newdata <- df[order(size_vec),]
df <- df[-23,]
print("Meann")
print(mean(df$size_vec))
print("SD")
print(sqrt(var(df$size_vec)))
# df2 <- data.frame(name_vec[46:104], size_vec[46:104],sample_type[46:104])
# colnames(df2) <- c("name_vec", "size_vec", "sample_type")
# ##probs should export this dataframe into .txt file
# p <- ggplot(data=df, aes(x= name_vec, y = size_vec, color=sample_type))+geom_point()+ylim(0, 100000)+theme( axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+labs(x="Name of sample", y= "# of enhancers")
# p
# ggsave("enhancer_count_plot_pointsall.png", plot = p)
# p1 <- ggplot(data=df, aes(x= reorder(name_vec, size_vec), y = size_vec, fill=sample_type))+geom_col()+ylim(0, 100000)+theme( axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size=8))+labs(x="Name of sample", y= "# of enhancers")
# p1
# ggsave("enhancer_count_plot_columnsall.png", plot = p1)
# p2 <- ggplot(data=df2, aes(x= name_vec, y = size_vec))+geom_point()+ylim(0, 100000)+theme( axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+labs(x="Name of sample", y= "# of enhancers")
# p2
# 
# ggsave("enhancer_count_plot_tissues_points.png", plot = p2)
# p3 <- ggplot(data=df2, aes(x= name_vec, y = size_vec))+geom_col()+ylim(0, 100000)+theme( axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))+labs(x="Name of sample", y= "# of enhancers")
# p3
# ggsave("enhancer_count_plot_tissues_cols.png", plot = p3)
