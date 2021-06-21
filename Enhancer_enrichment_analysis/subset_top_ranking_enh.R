###Short script to save the top ranking genes with score higher than 3.0

brain <- read.table("/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/Brain_cluster_ranking_enhancers.txt", header=T)
print(nrow(brain))
brain <- brain[brain$Gene_score >= 4.0,] 
brain <- na.omit(brain)
print(nrow(brain))
print(ncol(brain))
brain <- as.factor(brain$Gene_name)

write.table(brain, "/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/TopBrain_cluster_ranking_enhancers.txt", row.names = F, quote= F, sep="\t")

placenta <- read.table("/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/Placenta_cluster_ranking_enhancers.txt", header=T)
print(nrow(placenta))
placenta <- placenta[placenta$Gene_score >= 4.0,]
placenta <- na.omit(placenta)
placenta <- as.factor(placenta$Gene_name)
print(nrow(placenta))
write.table(placenta, "/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/TopPlacenta_cluster_ranking_enhancers.txt", row.names= F, quote=F,sep="\t" )
