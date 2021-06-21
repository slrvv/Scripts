#####SELECT only the tissues for the tables #####

run_type <- c("Single_ended/Cell_lines", "Pair_ended/Cell_lines")
dir <- "/project/CRUP_scores/CRUP_scores/RESULTS"
samplenames <-c()
for (run in run_type){
  path <- paste(dir,run, sep="/")
  bash_comm <- paste("ls", path, sep =" ") 
  sample_vec <- system(bash_comm, intern=T)
  samplenames <- c(samplenames, sample_vec)
  
} 
samplenames<- c("A549","ACC112","DND.41","DOHH2","GM12878","H1" ,"H9" ,"HCT116" ,"HUES48","HUES6","HUES64","HeLa.S3","HepG2", "IMR.90" ,"K562",
                "KMS.11","Karpas.422", "MCF.7","MM.1S","OCI.LY1","OCI.LY3","OCI.LY7","PC.3" ,"Panc.1", "SK.N.MC", "iPS.18a","iPS.20b", "iPS_DF_6.9", "A673","GM23248","GM23338","HAP.1","PC.9","SJCRH30","SJSA1","SK.N.SH", "UCSF.4") 
print(samplenames)
dat <- read.table("/project/CRUP_scores/Scripts/CA_tables/tableCA_clusteredchr13.txt",header= T, sep="\t", row.names= 1)
datt<- dat[,samplenames]
datt <- datt[rowSums(datt[])>0,]
rows <- rownames(datt)
datf<- cbind(rows, datt)
write.table(datf,"/project/CRUP_scores/Scripts/CA_tables/tableCA_clusteredchr13_cell_lines.txt", sep="\t", col.names=T, row.names= F)
