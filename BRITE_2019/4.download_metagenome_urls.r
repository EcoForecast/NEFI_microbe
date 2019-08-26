#### download code ####
library(RCurl)
library(utils)
# source functions:
setwd("BRITE_2019/") # assumes you're in NEFI_microbe
source("BRITE-paths.r")
source("../NEFI_functions/tic_toc.r")

# read in the file with the urls
#meta.data.file <- read.delim("2017_metagenome_sequences.txt")

# set a path for where things should download
download.dir <- "/projectnb/talbot-lab-data/NEFI_data/metagenomes/2017_raw_sequences/" 

# some files from NEON data contain information in sample sheets. This gets rid of those files 
#metagenomic data is downloaded 

#uses table made from organize_2017_metagenome_data.r
i <- 1
while (i <= nrow(raw_2017_sub)) {

  m.url <- raw_2017_sub[i, 14]
  my.url <- as.character(m.url)
  print(i)
  tic()
  download.file(url=my.url, destfile = paste0(download.dir, basename(my.url)))
  toc()
  i <- i+1
   
}

# list the files that were downloaded. For checking purposes. 
url.vector <- list.files(path = "/projectnb/talbot-lab-data/NEFI_data/metagenomes/2017_raw_sequences", pattern = NULL, all.files = FALSE,
           full.names = FALSE, recursive = FALSE,
           ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)



# code that I used to change file names. Might be useful for reference. 

from1 <- url.vector
to1 <- character()

for (i in 1:length(url.vector)) {
  
  middle <- substr(url.vector[i], 21, 22)
  front <- substr(url.vector[i], 1, 17)
  end <- substr(url.vector[i], 19, 20)
  sample <-paste0(front, middle, '_' ,end)
  to1[i] <- sample
  
}

#set directory to where sample files are located

setwd("/projectnb/talbot-lab-data/NEFI_data/metagenomes/2017_raw_sequences")

#rename files within that directory 
file.rename(url.vector,to1)

#Next firections:
#create and activate sunbeam environment. Website for reference: https://sunbeam.readthedocs.io/en/latest/quickstart.html
# create project in terminal using: sunbeam init 2017_project --data_fp /projectnb/talbot-lab-data/NEFI_data/metagenomes/2017_raw_sequences
#where data_fp is the filepath of your sequences 






