#Data wrangling (week 6)
#Christine Ribeiro 
#9.12.18

#libraries
library(dplyr)
library(tidyr)


# Read and check the data (task 1)

BPRS<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt",
                  header=T, sep=" ")

RATS<-read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",
                 header=T, sep="\t")

str(BPRS)
summary(BPRS)

str(RATS)
summary(RATS)

# Setting categorical variables to factors (task 2)

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert the data sets to long form (task 3)

BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks, 5, 5)))


RATSL <-  RATS %>% gather(key = WD, value = Weight, -Group, -ID)
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(WD, 3, 4)))

# Compare to wide data (task 4)

str(BPRSL)
head(BPRSL)
summary(BPRSL)
glimpse(BPRS)


str(RATSL)
head(RATSL)
summary(RATSL)
glimpse(RATS)

setwd("D:/New folder/OneDrive for Business 1/Git/IODS/IODS-project/data")
write.table(RATSL, file = "RATSL.txt", sep = " ", dec=".", row.names = FALSE, col.names = TRUE)
write.table(BPRSL, file = "BPRSL.txt", sep = " ", dec=".", row.names = FALSE, col.names = TRUE)




