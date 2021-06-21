###### Making plots of pathways ###

library(openxlsx)
library("readxl")
library(stringr)
library(ggplot2)
data <- as.data.frame(read_excel("/home/lopez_s/Downloads/SEanalysis_brain.xlsx", skip=1,  col_names = F))
pathways <- as.vector(data[,12])
pathways <- pathways[-1]
print(pathways)
pathways_formatted <- c()
for (element in pathways){
  pathways_formatted <- c(pathways_formatted, str_split(element, ","))
}
pathways_formatted_flat <- unlist(pathways_formatted, recursive = F)
path_unique <- unique(pathways_formatted_flat)
?order
pathway_data<- as.data.frame(table(pathways_formatted_flat))
pathway_data <- pathway_data[order(pathway_data$Freq, decreasing = T),]
write.table(pathway_data[1:10,], "/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/brain_top10enriched_SE.txt", sep="\t", quote=F, row.names = F)
unique(pathway_data$Freq)
p1<- ggplot(data=pathway_data, aes(reorder(pathways_formatted_flat,-Freq), Freq))+geom_point()
p1
