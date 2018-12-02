setwd("D:/New folder/OneDrive for Business 1/Git/IODS/IODS-project/data")
human <- read.table(file = "human.txt",
                    header = TRUE,
                    dec = ".")
 
# Library
library(GGally)
library(corrplot)
library(FactoMineR)
library(tidyr)
library(dplyr)
# Overview of data (task 1)
summary(human)
str(human)

ggpairs(human)
cor(human)%>%corrplot()

# PCA on raw data (task 2)
pca_human_raw <- prcomp(human, scale = FALSE)
pca_human_raw

# Among all variables, GNI had a stronger correlation with PC1. Since the variables weren't standardized,
# the magnitude and range of some variables, especially of GNI, was much greater, so the PCA gave more emphasis to GNI.

s <- summary(pca_human_raw)
s
# PC1 explains 100% of the total variance in the data.

# draw a biplot of the principal component representation and the original variables
biplot(pca_human_raw)

# PCA with standardized data (task 3)

pca_human_std <- prcomp(human, scale=TRUE)
pca_human_std

# Expec.birth, expect.edu, sec.edu, and GNI variables show a strong and negative correlation with PC1, while mort.ratio
# and adolbirth showed a strong positive correlation with PC1. Repres.par and lab.force showed a strong positive 
# correlation with PC2. We can say that PC1 represents well expec.edu

# create and print out a summary of pca_human
s <- summary(pca_human_std)
s

# assigning the proportion of variance as percent to each PC

pca_pr <- round(100*s$importance[2, ], digits = 1)
pc_lab<-paste0(names(pca_pr), " (", pca_pr, "%)")
pc_lab

#The PCA produced two components with eigenvalues (in units of standard deviation) above 1.0,
#which explained about 70% of the total variance among the eight original variables.

# draw a biplot of the principal component representation and the original variables
biplot(pca_human_std, cex = c(0.8, 1), col = c("grey40", "deeppink2"), xlab = pc_lab[1], ylab = pc_lab[2])

# Interpretation (task 4)
# We can see that PC1 and PC1 explained 53.6% and 16.2% of the total variance, respectively. 
# PC1 represents Expec.birth, expect.edu, sec.edu, and GNI, that strongly correlates with each other, which negatively
# correlate with mort.ratio and adol.virth, that strongly correlate with each other. ON the other hand, PC2
# represents repres.par and lab.force, which are independent from the other variables in the data set.
# You can see they are orthogonally positioned on the biplot.

# MCA

data("tea")
dim(tea)
str(tea)

keep_columns <- c("Tea", "age", "How", "where", "friends", "breakfast")
tea_time <- select(tea, one_of(keep_columns))
summary(tea_time)
gather(tea_time) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") +geom_bar()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))

mca <- MCA(tea_time, quanti.sup= 2, graph = FALSE)
summary(mca)
# Of all variables,"where" correlated more strongly with dimension 1 (but also with dimension 3),
# whereas "How" correlated more with dimension 2."Tea" type correlated with dimension 3.
# All variables were significant in dim 1.
# Chain store+tea shop was not significant for dim 2 nor for dim 3.
# Tea with milk was not significant for dim 3.
dimdesc(mca)
# Age is significantly correlated with dim 2 (p<0.05) and dim 3 (p<0.001).

plot(mca, invisible=c("ind"),habillage = "quali")



