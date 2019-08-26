setwd("/projectnb/talbot-lab-data/NEFI_data/metagenomes/sunbeam-stable/extensions/sbx_report")
install.packages("rmarkdown")
rmarkdown::render("example.html")
download.file("example.html")
library(reshape2)
library(ggplot2)

#bart sample <- 769473 reads
#DSNY sample <- 5796356 reads
#OSBS sample <- 2764342 reads
#SCBI sample <- 2169130 reads
#WOOD sample <- 725509 reads

i <- 1
genes.norm <- trans2

while (i < 69) {
  #SCBI
  genes.norm[1,i] <- (genes.norm[1,i]/2169130)*1000000
  #DSNY
  genes.norm[2,i] <- (genes.norm[1,i]/5796356)*1000000
  #BART
  genes.norm[3,i] <- (genes.norm[1,i]/769473)*1000000
  #OSBS
  genes.norm[4,i] <- (genes.norm[1,i]/5796356)*1000000
  #WOOD
  genes.norm[5,i] <- (genes.norm[1,i]/725509)*1000000
  i <- i + 1
}

df <- as.data.frame(genes.norm)
library(dplyr)
df <- tibble::rownames_to_column(df, "Sample")
df[1,1] <- "SCBI"
df[2,1] <- "DSNY"
df[3,1] <- "BART"
df[4,1] <- "OSBS"
df[5,1] <- "WOOD"
df_long <- melt(df, id.vars = "Sample", variable.name = "Gene")

plot1 <- ggplot(df_long, aes(x = Sample, y = value, fill = Gene)) + 
  geom_bar(stat = "identity", position="stack", colour = "black")


