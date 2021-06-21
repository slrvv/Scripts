############################PCA analysis############################

##Script to perform PCA analysis on the 0-1 contingency table.


######LIBRARIES######

library(PCAtools)
library(ggfortify)
library(plot3D)
library(plotly)
library(orca)
library(processx)
library(tidyverse)
library(grid)
library(ggplot2)
library(ggrepel)
library(stringr)


######DIRECTORIES AND LOADING THE DATA######


path <- "/project/CRUP_scores/Scripts/CA_tables/Use"
bash_comm <- paste("ls", path, sep =" ")
sample_vec <- system(bash_comm, intern=T)

##Go through all of the table CA files
for(filetable in sample_vec){
  print(filetable)
  path_res <- paste("/home/lopez_s/Plots/",filetable,".png")
  
  ###Load metadata and contingency table
  ##metadata file . Used to get the lab of each sample
  metadata <- read.csv(file= "/project/CRUP_scores/CRUP_scores/summary.tsv", header= T, sep= "\t")
  metadata$Lab <- as.character(metadata$Lab)
  metadata$Name.of.sample <- as.character(metadata$Name.of.sample)
  ##Contingency table (data for the PCA)
  data <- read.table(paste(path,filetable, sep="/"),header= T, sep="\t", row.names= 1)
  data <- data[rowSums(data[])>0,]
  data <- as.data.frame(t(data))
  
  
  ###Get the lab of 
  samplenames <- rownames(data)
  samplenames
  samplenames_f <- c()
  ##Formatting issue
  for (samples in samplenames){
    if (samples == "iPS_DF_6.9" | samples == "MM.1S" ){
      samplenames_f <- c(samplenames_f, samples)
    }
    else{
      samplenames_f <- c(samplenames_f, str_replace_all(samples, "[.]", "-"))
    }
  }
  print(samplenames_f)
  labs<- c()
  ##get the labs in the order that our data is in. 
  for (sample in samplenames_f){
    labs <- c(labs, metadata[which(metadata$Name.of.sample== sample), 4])
    print(sample)
  }
  
  ######PCA AND PLOTS######
  
  ##PCA and make result a dataframe so it is easy to plot
  pca <- prcomp(data)
  df_out<- as.data.frame(as.data.frame(pca$x)) #make the result into a dataframe
  df_out$group <- sapply( as.character(row.names(data)), "[[", 1 )# add the names of the sample
  var_explained <- pca$sdev^2/sum(pca$sdev^2)
  df_out$lab <- as.character(labs)##add the name of the labs
  df_out$type <- c(rep("Primary_cells",8), rep("Cell_lines",37 ), rep("Tissues", 59))
  ##Plot the scores into a 2d space and save it as png
  png(file = path_res)
  p<-ggplot(df_out,aes(x=PC1,y=PC2,label=group, color= as.factor(type)))+geom_point(aes(shape= as.factor(lab)), size=3)+
    scale_color_viridis_d(direction=-1, end= 0.75)+scale_shape_manual(values=c(2, 19, 3, 5, 8,1,  17))+
    labs(x=paste0("PC1: ",round(var_explained[1]*100,1),"%"),y=paste0("PC2: ",round(var_explained[2]*100,1),"%"),color="Type of sample",shape="Lab",title= "PCA on clustered enhancers")+
    theme(legend.text=element_text(size=8), legend.title = element_text(size=8))+
    geom_text_repel(data = subset(df_out, group %in% c("cingulate_gyrus","angular_gyrus","layer_hippocampus", "temporal_lobe", "caudate_nucleus", "middle_frontal_area_46", "chorion", "chorionic_villus","placenta", "placental_basal_plate", "esophagus", "lung", "PC.3", "neurosphere", "gastroesophageal_sphincter", "HUES6", "A549", "amnion")))
  
  print(p)
  dev.off()
  
}

