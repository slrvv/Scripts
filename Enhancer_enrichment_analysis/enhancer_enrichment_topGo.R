##### Enrichment analysis top Go ######

#libraries
library(clusterProfiler)
library(ggplot2)
library(stringr)
library(DOSE)
#BiocManager::install("clusterProfiler")
###Analysis for the Brain cluster

##load the data from the most associated enhancers
apl_data <- na.omit(read.table("/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/Brain_cluster_ranking_enhancers.txt", header= T))

##create 3 different subsets : gene score equal or above 1, equal or above 2, equal or above 3.
apl_data_sub_1 <- apl_data[apl_data$Gene_score >= 1.0,]
apl_data_sub_1_nrows <- nrow(apl_data_sub_1)
apl_data_sub_2 <- apl_data[apl_data$Gene_score >= 2.0,]
apl_data_sub_2_nrows <- nrow(apl_data_sub_2)
apl_data_sub_3 <- apl_data[apl_data$Gene_score >= 3.0,]
apl_data_sub_3_nrows <- nrow(apl_data_sub_3)

##load files of mapped enhancers 
enh_gene_map <- read.table("/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/brain_enhancers_closestgene.txt", header=T)
##we have to format the chromosome notation 
enh_element_formatted <- str_replace(enh_gene_map$enhancer_element, "[:]", " ")
enh_element_formatted <- str_replace(enh_element_formatted, "[-]", " ")
enh_gene_map <- cbind(enh_gene_map, enh_element_formatted)

###get the subset of genes
enh_gene_map_sub_1 <- subset(enh_gene_map, enh_element_formatted %in% apl_data_sub_1$Gene_name) #why are the numbers not the same??
enh_gene_map_sub_2 <- subset(enh_gene_map, enh_element_formatted %in% apl_data_sub_2$Gene_name)
enh_gene_map_sub_3 <- subset(enh_gene_map, enh_element_formatted %in% apl_data_sub_3$Gene_name)

##get the genes 
genes_map_sub_1 <- as.character(unique(enh_gene_map_sub_1$closest_gene_name))
genes_map_sub_2 <- as.character(unique(enh_gene_map_sub_2$closest_gene_name))
genes_map_sub_3 <- as.character(unique(enh_gene_map_sub_3$closest_gene_name))

## Enrichment analysis
library(org.Hs.eg.db)

gene.df <- bitr(genes_map_sub_1, fromType = "SYMBOL",
                toType = c("ENTREZID", "ENSEMBL"),
                OrgDb = org.Hs.eg.db)
ego <- enrichGO(gene.df$ENTREZID,
                OrgDb         = org.Hs.eg.db,
                keyType       = 'ENTREZID',
                ont           = "BP",
                pAdjustMethod = "BH",
                pvalueCutoff  = 0.01,
                qvalueCutoff  = 0.05)
head(summary(ego))
dotplot(ego, showCategory=30)
#DOSE::enrichMap(ego, vertex.label.cex=1.2, layout=igraph::layout.kamada.kawai)
plotGOgraph(ego)
#install.packages("DOSE")

gene.df2 <- bitr(genes_map_sub_2, fromType = "SYMBOL",
                toType = c("ENTREZID", "ENSEMBL"),
                OrgDb = org.Hs.eg.db)
ego2 <- enrichGO(gene.df2$ENTREZID,
                OrgDb         = org.Hs.eg.db,
                keyType       = 'ENTREZID',
                ont           = "BP",
                pAdjustMethod = "BH",
                pvalueCutoff  = 0.01,
                qvalueCutoff  = 0.05)
head(summary(ego2))
dotplot(ego2, showCategory=30)
#ModifiedDOSE::enrichMap(ego, vertex.label.cex=1.2, layout=igraph::layout.kamada.kawai)
plotGOgraph(ego)

gene.df3 <- bitr(genes_map_sub_3, fromType = "SYMBOL",
                 toType = c("ENTREZID", "ENSEMBL"),
                 OrgDb = org.Hs.eg.db)
ego3 <- enrichGO(gene.df3$ENTREZID,
                 OrgDb         = org.Hs.eg.db,
                 keyType       = 'ENTREZID',
                 ont           = "BP",
                 pAdjustMethod = "BH",
                 pvalueCutoff  = 0.01,
                 qvalueCutoff  = 0.05)
out <- as.data.frame(cbind(ego3$ID, ego3$p.adjust))
?write.table()
#write.table(out, "/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/Output_enrichment_brain.txt",quote=F, row.names=F)
#head(summary(ego3))
png("/project/CRUP_scores/Scripts/dotplot_brain_better.png")
dotplot(ego3, showCategory=30)+theme(axis.text.y = element_text(size = 10)) 
dev.off()



###Analysis for the Placenta/chorion clusters

apl_data <- na.omit(read.table("/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/Placenta_cluster_ranking_enhancers.txt", header= T))

##create 3 different subsets : gene score equal or above 1, equal or above 2, equal or above 3.
apl_data_sub_1 <- apl_data[apl_data$Gene_score >= 1.0,]
apl_data_sub_1_nrows <- nrow(apl_data_sub_1)
apl_data_sub_2 <- apl_data[apl_data$Gene_score >= 2.0,]
apl_data_sub_2_nrows <- nrow(apl_data_sub_2)
apl_data_sub_3 <- apl_data[apl_data$Gene_score >= 3.0,]
apl_data_sub_3_nrows <- nrow(apl_data_sub_3)

##load files of mapped enhancers 
enh_gene_map <- read.table("/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/placenta_enhancers_closestgene.txt", header=T)
##we have to format the chromosome notation 
enh_element_formatted <- str_replace(enh_gene_map$enhancer_element, "[:]", " ")
enh_element_formatted <- str_replace(enh_element_formatted, "[-]", " ")
enh_gene_map <- cbind(enh_gene_map, enh_element_formatted)

###get the subset of genes
enh_gene_map_sub_1 <- subset(enh_gene_map, enh_element_formatted %in% apl_data_sub_1$Gene_name) #why are the numbers not the same??
enh_gene_map_sub_2 <- subset(enh_gene_map, enh_element_formatted %in% apl_data_sub_2$Gene_name)
enh_gene_map_sub_3 <- subset(enh_gene_map, enh_element_formatted %in% apl_data_sub_3$Gene_name)

##get the genes 
genes_map_sub_1 <- as.character(unique(enh_gene_map_sub_1$closest_gene_name))
genes_map_sub_2 <- as.character(unique(enh_gene_map_sub_2$closest_gene_name))
genes_map_sub_3 <- as.character(unique(enh_gene_map_sub_3$closest_gene_name))


gene.df1 <- bitr(genes_map_sub_1, fromType = "SYMBOL",
                 toType = c("ENTREZID", "ENSEMBL"),
                 OrgDb = org.Hs.eg.db)
ego1 <- enrichGO(gene.df1$ENTREZID,
                 OrgDb         = org.Hs.eg.db,
                 keyType       = 'ENTREZID',
                 ont           = "BP",
                 pAdjustMethod = "BH",
                 pvalueCutoff  = 0.01,
                 qvalueCutoff  = 0.05)

dotplot(ego1, showCategory=30)


gene.df2 <- bitr(genes_map_sub_2, fromType = "SYMBOL",
                 toType = c("ENTREZID", "ENSEMBL"),
                 OrgDb = org.Hs.eg.db)
ego2 <- enrichGO(gene.df2$ENTREZID,
                 OrgDb         = org.Hs.eg.db,
                 keyType       = 'ENTREZID',
                 ont           = "BP",
                 pAdjustMethod = "BH",
                 pvalueCutoff  = 0.01,
                 qvalueCutoff  = 0.05)

dotplot(ego2, showCategory=30)

gene.df3 <- bitr(genes_map_sub_3, fromType = "SYMBOL",
                 toType = c("ENTREZID", "ENSEMBL"),
                 OrgDb = org.Hs.eg.db)
ego3 <- enrichGO(gene.df3$ENTREZID,
                 OrgDb         = org.Hs.eg.db,
                 keyType       = 'ENTREZID',
                 ont           = "BP",
                 pAdjustMethod = "BH",
                 pvalueCutoff  = 0.01,
                 qvalueCutoff  = 0.05)
out <- as.data.frame(cbind(ego3$ID, ego3$p.adjust))
?write.table()
write.table(out, "/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/Output_enrichment_placenta.txt",quote=F, row.names=F)
head(summary(ego3))
barplot(ego3, showCategory=30)
