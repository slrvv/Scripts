#################################################
#######CA analysis on all of the chromosomes#####
#################################################

###This was not what we ended up using.

# install.packages(c("FactoMineR", "factoextra"))
library("FactoMineR")
library("factoextra")
filetable <- "/project/CRUP_scores/Scripts/tableCA_clusteredenh.txt"
data <- read.table(filetable,header= T, sep="\t", row.names= 1)
nrow(data)
res.ca <- CA(data, graph = FALSE)
res.ca
# chisq <- chisq.test(data)
# chisq
# fish <- fisher.test(data, simulate.p.value= T)
# fish
eig.val <- get_eigenvalue(res.ca)
eig.val
png("/home/lopez_s/Plots/CA_screeplot_all.png")
fviz_screeplot(res.ca, addlabels = TRUE, ylim = c(0, 104))
dev.off()
png("/home/lopez_s/Plots/CA_biplot_all.png")
fviz_ca_biplot(res.ca, label= "col")
dev.off()

