#########Distribution enhancer scores#########

#Script to generate plots for the distribution of the enhancer scores

library(ggplot2)

data <- read.table("/project/CRUP_scores/Scripts/Placenta_cluster_ranking_enhancers.txt", header=T)
data<- na.omit(data)
print(nrow(data))
png("/home/lopez_s/Plots/Dist_genescores_placenta.png")
ggplot(data, aes(x=Gene_score)) +
  geom_histogram(aes(y=..count..),      # Histogram with density instead of count on y-axis
                 binwidth=.5,
                 colour="black", fill="white") +
  geom_vline(aes(xintercept=mean(Gene_score, na.rm=T)),color="black", linetype="dashed", size=1)+labs(title="Distribution of gene scores placenta/chorion cluster", caption=paste("Number of enhancers: ", as.character(nrow(data))))+theme_minimal()
dev.off()

data2 <- read.table("/project/CRUP_scores/Scripts/Brain_cluster_ranking_enhancers.txt", header=T)
data2<- na.omit(data2)
print(nrow(data2))
png("/home/lopez_s/Plots/Dist_genescores_brain.png")
ggplot(data2, aes(x=Gene_score)) +
  geom_histogram(aes(y=..count..),      # Histogram with density instead of count on y-axis
                 binwidth=.5,
                 colour="black", fill="white") +
  geom_vline(aes(xintercept=mean(Gene_score, na.rm=T)),color="black", linetype="dashed", size=1)+labs(title="Distribution of gene scores brain cluster", caption=paste("Number of enhancers: ", as.character(nrow(data2))))
dev.off()
