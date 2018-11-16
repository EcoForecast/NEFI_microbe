#Fit MULTINOMIAL dirlichet models to YEAST groups of fungi from Tedersoo et al. Temperate Latitude Fungi.
#No hierarchy required, as everything is observed at the site level. Each observation is a unique site.
#Missing data are allowed.
#clear environment
rm(list = ls())
library(data.table)
library(doParallel)
source('paths.r')
source('NEFI_functions/dmulti-ddirch_site.level_JAGS.r')

#detect and register cores.----
n.cores <- detectCores()
registerDoParallel(cores=n.cores)

#set output path.----
output.path <- ted_ITS.prior_dmulti.ddirch_yeast_JAGSfit

#load tedersoo data.----
d <- data.table(readRDS(tedersoo_ITS_clean_map.path))
y <- readRDS(tedersoo_ITS_yeast_list.path)
seq.depth <- y$seq_total
y <- y$abundances
d <- d[,.(SRR.id,pC,cn,pH,moisture,NPP,map,mat,forest,conifer,relEM)]
#add interaction.
d$relEM_forest <- d$relEM*d$forest

d <- d[complete.cases(d),] #optional. This works with missing data.
seq.depth <- seq.depth[names(seq.depth) %in% d$SRR.id]
y <- y[rownames(y) %in% d$SRR.id,]
y <- as.data.frame(y)
testing = F
if(testing == T){
  d <- d[1:20,] #for testing
  y <- y[rownames(y) %in% d$SRR.id,]
}


#Drop in intercept, setup predictor matrix.----
#IMPORTANT: LOG TRANSFORM MAP.
d$intercept <- rep(1,nrow(d))
d$map <- log(d$map)
x <- d[,.(intercept,pC,cn,pH,moisture,NPP,mat,map,forest,conifer,relEM,relEM_forest)]

#define multiple subsets
x.clim <- d[,.(intercept,NPP,mat,map)]
x.site <- d[,.(intercept,pC,cn,pH,forest,conifer,relEM,relEM_forest)]
x.all  <- d[,.(intercept,pC,cn,pH,NPP,mat,map,forest,conifer,relEM,relEM_forest)]
x.list <- list(x.clim,x.site,x.all)

#fit model using function.----
#This take a long time to run, probably because there is so much going on.
#fit <- site.level_dirlichet_jags(y=y,x_mu=x,adapt = 50, burnin = 50, sample = 100)
#for running production fit on remote.
output.list<-
  foreach(i = 1:length(x.list)) %dopar% {
    fit <- site.level_multi.dirich_jags(y=y,seq.depth=seq.depth,x_mu=x.list[i],adapt = 200, burnin = 6000, sample = 5000, parallel = T)
    return(fit)
  }

#get intercept only fit.
#output.list[[length(x.list) + 1]] <- site.level_dirlichet_intercept.only_jags(y=y, silent.jags = T)

#name the items in the list, save output.----
names(output.list) <- c('climate.preds','site.preds','all.preds')

cat('Saving fit...\n')
saveRDS(output.list, output.path)
cat('Script complete. \n')
