library(RCurl)
library(utils)
library(tidyverse)
library(devtools)
install.packages("ggplot2")
library(ggplot2)
library(ggfortify)
library(ggbiplot)

d <-read.table("NCyc_out.txt", header=TRUE, sep="\t")
trans <- t(d)  
colnames(trans) = trans[1, ]
trans <-  trans[-1, ]

trans2 <- type.convert(trans[1:5,1:68])
trans3 <- t(trans2)

genes.pca <- prcomp(trans2[1:5,1:68], center = TRUE, scale. = TRUE)

summary(genes.pca)

autoplot(genes.pca)
#ggbiplot(genes.pca, ellipse = TRUE, labels=rownames(trans2), groups = )
