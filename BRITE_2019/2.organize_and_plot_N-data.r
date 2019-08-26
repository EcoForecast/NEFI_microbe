setwd("BRITE_2019/") # assumes you're in NEFI_microbe
source("BRITE-paths.r")
library(neonUtilities)  
library(neonNTrans) 
library(ggplot2)

#reads in output from download_merge_N_trans.r script
out <- readRDS(N_data_path)
meta.dat <- loadByProduct(site = "all", dpID = "DP1.10107.001", package="basic", check.size=F)
seq <- meta.dat[["mms_metagenomeSequencing"]]

# subset both dfs (out and seq) to 2017
n_2017 <- out[substr(out$dateID, 1, 4) == "2017",]
seq_2017 <- seq[substr(seq$collectDate, 1, 4) == "2017", ]

# create new mergeID for both
# first part of sampleID (without date)
i <- 1622
n_2017 <- n_2017[!duplicated(n_2017$uid.y),]

n_2017$mergeSampleID <- NA
for (i in 1:nrow(n_2017)) {
  print(i)
  samp <- n_2017$incubationPairID[i]
  samp_rows <- n_2017[n_2017$incubationPairID == samp, ]
  samp_first_date <- samp_rows[samp_rows$nTransBoutType=="tInitial",]$dateID
  mergeSampleID <- paste0(substr(samp_rows$sampleID[1], 1, 10), "-", samp_first_date)
  n_2017[n_2017$incubationPairID == samp,]$mergeSampleID <- mergeSampleID
}
# in sequence data, create ID with site/plot/year-month

seq_2017$mergeSampleID <- NA
for (i in 1:209) {
  samp <- seq_2017$dnaSampleID[i]
  new_date <- substr(seq_2017$collectDate[i], 1, 7)
  samp_first_date <- new_date
  mergeSampleID <- paste0(substr(seq_2017$dnaSampleID[i], 1, 10), "-", samp_first_date)
  seq_2017[seq_2017$dnaSampleID == samp,]$mergeSampleID <- mergeSampleID
}

# subset nitrogen data to nTransBoutType.x == "tFinal"
n_2017 <- n_2017[n_2017$nTransBoutType == "tFinal", ]

# merge by mergeID
merge1 <- merge(n_2017, seq_2017, by = "mergeSampleID")

#get rid of duplicated columns 
newmerge <- merge1[!duplicated(as.list(merge1))]

#N min boxplot separated by siteID
nmin_plot <- ggplot(newmerge, aes(x= siteID.x, y= netNminugPerGramPerDay)) +
  geom_boxplot()
nmin_plot

#nitrification boxplot separated by siteID
nit_plot <- ggplot(newmerge, aes(x= siteID.x, y= netNitugPerGramPerDay)) +
  geom_boxplot()
nit_plot

# save metadata 
saveRDS(nit_plot, meta_data_path)

#### old

# new_meta_sequence <- merge(out, meta.dat[["mms_metagenomeSequencing"]], by.x = "collectDate.x", by.y = "collectDate")
# 
# #dim = 405 rows
# new_meta_dna <- merge(out, meta.dat[["mms_metagenomeDnaExtraction"]], by.x = "collectDate", by.y = "collectDate")