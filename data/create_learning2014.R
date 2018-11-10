#Christine Ribeiro
#10.11.2018
#Data wrangling for IODS-project (week 2)

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(lrn14)
# [1] 183  60 (rows by collumns)
str(lrn14)
#183 observations of  60 variables

lrn14$attitude <- lrn14$Attitude / 10

# lrn14 is available

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$strategic <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "strategic", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# change the name of "Points" to "points"
colnames(learning2014)[2] <- "age"
# change the name of "Points" to "points"
colnames(learning2014)[5] <- "stra"
# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"
colnames(learning2014)

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)

# see the stucture of the new dataset
str(learning2014)

setwd("D:/New folder/OneDrive for Business 1/Git/IODS/IODS-project/data")
write.table(learning2014, file = "learning2014.txt", sep = " ", dec=".", row.names = FALSE, col.names = TRUE)

learning2014 <- read.table(file = "learning2014.txt",
                            header = TRUE,
                            dec = ".")
head(learning2014)
