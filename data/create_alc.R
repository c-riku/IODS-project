#Christine Ribeiro
#18.11.2018
#Data wrangling for IODS-project (week 3)
#Merging data sets of student achievements in Mathematics and Portuguese.
#Paulo Cortez, University of Minho, Guimarães, Portugal, http://www3.dsi.uminho.pt/pcortez 

# Working directory
setwd("D:/New folder/OneDrive for Business 1/Git/IODS/IODS-project/data")

# Libraries
library(dplyr)

# Datasets (task 3)
math <- read.csv("student-mat.csv", sep=";")

por <- read.csv("student-por.csv", sep=";")

str(math)
dim(math)

str(por)
dim(por)

# Merge datasets (task 4)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu",
             "Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(math, por, by = join_by, suffix=c(".math", ".por"))

names(math_por)
glimpse(math_por)
str(math_por)
dim(math_por)


# Deal with duplication (task 5)
alc <- select(math_por, one_of(join_by))
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

for(column_name in notjoined_columns) {
    two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
    if(is.numeric(first_column)) {
        alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

# New alcohol consumption variables (task 6)
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse and save
glimpse(alc)

write.table(alc, file = "alc.txt",
            sep = " ", dec=".", row.names = FALSE, col.names = TRUE)
head(alc)

