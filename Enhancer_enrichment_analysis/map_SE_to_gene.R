####Find overlapping super enhancers in brain and select gene######

library(regioneR)
library(GenomicRanges)
##brain cluster
brain_SE <- read.table("/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/SE_package_placenta.bed",header=T,sep ="\t")
brain_SE <- brain_SE[,c(3, 4, 5, 18)]
brain <- read.table("/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/placenta_toenrich_hg19.bed", header = F, sep ="\t")
colnames(brain) <- c("chr", "start", "end")
brain_rle <- toGRanges(brain)
brain_SE_rle <- toGRanges(brain_SE)
overlaps <- findOverlaps(brain_rle,brain_SE_rle, type="any", minoverlap = 1L)
hits <- subjectHits(overlaps)
brain_SE[hits,]
brain_genes <- brain_SE[hits,]$closest.active.gene
genes <- as.data.frame(as.character(brain_genes))
colnames(genes) <- "Gene_names"
write.table(genes, "/project/CRUP_scores/Scripts/Enhancer_enrichment_analysis/placenta_genes.txt", col.names = T, row.names = F, quote= F)