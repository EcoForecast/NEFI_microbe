library(neonUtilities)



# read in soil microbe mms L1 data

L1mic <- loadByProduct(startdate = "2013-01", enddate = "2017-12", dpID = 'DP1.10107.001', check.size = FALSE, package='expanded')

#L1mic.dna <- L1mic$mms_metagenomeDnaExtraction   # create data frame for metagenome DNA extraction data

#L1mic.dna <- L1mic.dna[grep("metagenomics", L1mic.dna$sequenceAnalysisType),]  # filter to only DNA extraction records for metagenomics (raw data also has marker gene records)

#L1mmsSeq <- L1mic$mms_metagenomeSequencing   # create data frame for metagenome sequencing L1 data

L1mmsRaw <- L1mic$mms_rawDataFiles   # create data frame for metagenome raw data files

L1mmsRaw$dateID <- substr(L1mmsRaw$startDate, 1, 7)
raw_2017 <- L1mmsRaw[L1mmsRaw$dateID > "2017-01",]

#2017 sites with N-data: 
#KONZ
#ORNL
#SCBI
#STEI
#TALL

#subset 2017 raw data to these sites^^

raw_2017_sub = raw_2017[FALSE,]

for (i in 1:nrow(raw_2017)) {
  
  if (length(grep('KONZ', raw_2017[i, 3], value = TRUE)) != 0) {
   
     raw_2017_sub[i,] = raw_2017[i,]
  }
  if (length(grep('ORNL', raw_2017[i, 3], value = TRUE)) != 0) {
    
    raw_2017_sub[i,] = raw_2017[i,]
  }
  if (length(grep('SCBI', raw_2017[i, 3], value = TRUE)) != 0) {
    
    raw_2017_sub[i,] = raw_2017[i,]
  }
  if (length(grep('STEI', raw_2017[i, 3], value = TRUE)) != 0) {
    
    raw_2017_sub[i,] = raw_2017[i,]
  }
  if (length(grep('TALL', raw_2017[i, 3], value = TRUE)) != 0) {
    
    raw_2017_sub[i,] = raw_2017[i,]
  }
  
}  
#get rid of empty rows and NA columns
raw_2017_sub <- raw_2017_sub[,c(1,2,3,4,5,6,7,8,9,10,12,13,14,15,18)]
raw_2017_sub <- raw_2017_sub[complete.cases(raw_2017_sub), ]
#only take three samples from each site
raw_2017_sub <- raw_2017_sub[c(1:6, 21:26, 45:50, 65:70, 105:110), ]

raw_2017_sub$rawDataFilePath



