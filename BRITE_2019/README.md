#### Metagenome Data

The goal of the download_merge_N_trans.r, metagenomeCode.r, and download_meta.r scripts is to interpret nitrogen data from soil samples, attribute increases in soil nitrogen to the bacteria taxa present in the soil samples, and download metagenome sequences from soil samples, respectively. 

The scripts should be run in this order:  
1) download_merge_N_trans.r  
2) metagenomeCode.r  
3) download_meta.r  

### download_merge_N_trans.r  

This script loads in NEON nitrogen data from the product DP1.10080.001. Net nitrogen mineralization and net nitrification rates are then calculated from the downloaded soil data. Physical soil data from the same sites as the nitrogen data are then downloaded from the NEON product DP1.10086.001. Precise geographical data is added from geoNEON for specific coordinates. Relevant data from both of these data sets are combined based on the site and pot ID's of the soil samples. The final output is saved as an R script and used in the subsequent R script for data analysis.  

### metagenomeCode.r  

This script loads the output R script from the download_merge_N_trans.r script. Metadata for 2017 metagenomics sequencing is then downloaded from the NEON product DP1.10107.001. The nitrogen data is subset to 2017 collection dates only to match with the metagenomic sequence data colection dates. Metagenoic data is linked to nitrogen data through common colection dates and sample ID's. Data is analyzed through the creation of box plots relating net min nitrogen rates of soil cores to the different sites. Similarly, a box plot is made for net nitrogen rates. The plots are then saved as R scripts.   

### download_metagenome_urls.r  

This last script reads in a file containing information about microbial metagenome sequences. An output path is specified. The metagenome sequences are downloaded and their individual download times are calculated.
