library(TransPhylo)
library(lubridate)
library(ape)

#The most recent sequences sampling date
L_Date = decimal_date(ymd("2020-07-22"))

#Generate TransPhylo pTree. Ensure the newick file is in the same folder as the R scipt
ptree<-ptreeFromPhylo(read.tree('sample.nwk'),dateLastSample=L_Date)

#Infection rate parameters 1 to 14 days 
shape = 1
scale = 0.01917

#Sampling rate paramters 2 to 14 days
sShape = 1
sScale = 0.01917

#The date the experiment was stopped
Stop_Date = decimal_date(ymd("2020-08-22"))

#Generation of the MCMC chain
mcmc_Tree = inferTTree(ptree,mcmcIterations=150000,w.shape=shape,w.scale=scale,ws.shape = sShape,
                       ws.scale = sScale,dateT=Stop_Date,startPi=0.75)

#Plot the inferred sampling rate and inferred unsampled patients
pdf("sample_rate.pdf") 
a=getIncidentCases(mcmc_Tree,show.plot = T)
dev.off() 

#Plot the MCMC tracer diagram
pdf("sample_MCMC_tracer.pdf") 
plot(mcmc_Tree)
dev.off() 

lastIteration = mcmc_Tree[[length(mcmc_Tree)]]

#Plot the inferred transmission tree
pdf("sample.pdf") 
plotCTree(lastIteration$ctree,showLabels = FALSE)
dev.off() 

comb = lastIteration$ctree
lent = extractTTree(comb)
trans_Tree = lent$ttree
names = lent$nam

na_vect = rep("NA", length(trans_Tree[,1]) - length(names))
id_vect = c(names, na_vect)

tmp = as.data.frame(trans_Tree)
tmp[,1] = as.numeric(as.character(tmp[,1]))
tmp[,2] = as.numeric(as.character(tmp[,2]))

dates = tmp$V1
First_date = min(dates)
print(First_date)
First = format(date_decimal((min(dates))),"%Y-%m-%d")
print(First)


lent = extractTTree(lastIteration$ctree)
report = lent$ttree
nam = lent$nam
na_vect = rep("NA", length(report[,1]) - length(names))
id_vect = c(nam, na_vect)
tmp = as.data.frame(report)
tmp[,1] = as.numeric(as.character(tmp[,1]))
tmp[,2] = as.numeric(as.character(tmp[,2]))
report2 = data.frame(matrix(NA, nrow = nrow(tmp), ncol = ncol(tmp) + 2))
for (r in 1:length(tmp[,1])) {
  report2[r,1] = r
  report2[r,2] = id_vect[r]
  report2[r,3] = format(date_decimal(tmp[r,1]), "%Y-%m-%d")
  report2[r,4] = format(date_decimal(tmp[r,2]), "%Y-%m-%d")
  if (0 < tmp[r,3] && tmp[r,3] <= length(names)) {
    id = tmp[r,3]
    report2[r,5] = nam[id]
  } else {
    report2[r,5] = tmp[r,3]
  }
}

#Resultant transmission network
file = paste(getwd(),"/sample.tsv", sep = "")
write.table(report2, file=file, quote=FALSE, sep='\t', row.names = FALSE, col.names = c("Patient No.","Patient ID","Infection Date (Pred.)","Sampling Date","Source"))
