source("BRITE_2019/BRITE-paths.r")
library(neonUtilities)
library(neonNTrans) 
library(RCurl) # load "merge_left" function
script <- getURL("https://raw.githubusercontent.com/zoey-rw/NEFI_microbe/master/NEFI_functions/merge_left.r")
eval(parse(text = script))

NTR <- loadByProduct(site = "all", dpID = "DP1.10080.001", package = "basic", check.size = F)
#NTR.new <- loadByProduct(site = "all", dpID = "DP1.10080.001", package = "expanded", check.size = F)

# calculate net N mineralization and nitrification rates and put into table
nitr.out <- def.calc.ntrans(kclInt = NTR$ntr_internalLab, 
                       kclIntBlank = NTR$ntr_internalLabBlanks, 
                       kclExt = NTR$ntr_externalLab, 
                       soilMoist = NTR$sls_soilMoisture,
                       keepAll = T)

#getPackage(site_code = "HARV", dpID = "DP1.10080.001", package = "expanded", year_month="2018-04")


# soil physical properties
dat <- loadByProduct(site = "all", dpID = "DP1.10086.001", package = "basic", check.size = F)

# Rename dataframes
core.data <- dat$sls_soilCoreCollection
moisture.data <- dat$sls_soilMoisture
pH.data <- dat$sls_soilpH

# Merge moisture into soil cores
core.data <- merge_left(core.data,moisture.data, all.x = T)

# Merge pH into soil cores
output <- merge_left(core.data,pH.data, all.x = T)

# Add a couple columns for later
output$dateID <- substr(output$collectDate,1,7)
output$site_date <- paste(output$siteID, output$dateID)

# Add precise geolocation data
core.data <- geoNEON::def.calc.geo.os(output, 'sls_soilCoreCollection')
dim(core.data)

# merge soil core data with N cycling data
merge.output <- merge_left(core.data, nitr.out, by.col = c("sampleID", "plotID"))

# save output
saveRDS(merge.output, N_data_path)


