#Christine Ribeiro
#25.11.2018

#Task 2

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv",
               stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv",
                stringsAsFactors = F, na.strings = "..")
#Task 3
str(hd)
dim(hd)
summary(hd)


str(gii)
dim(gii)
summary(gii)

#Task 4
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "expec.birth"
colnames(hd)[5] <- "expec.edu"
colnames(hd)[6] <- "mean.edu"
colnames(hd)[7] <- "grossincome"
colnames(hd)[8] <- "GNI"

colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "mort.ratio"
colnames(gii)[5] <- "adol.birth"
colnames(gii)[6] <- "repres.par"
colnames(gii)[7] <- "sec.eduF"
colnames(gii)[8] <- "sec.eduM"
colnames(gii)[9] <- "labF"
colnames(gii)[10] <- "labM"


#Task 5

library(dplyr)
gii<-mutate(gii,sec.edu=(sec.eduF/sec.eduM))
gii<-mutate(gii,lab.force=(labF/labM))

#Task 6
join_by <- c("Country")
human <- inner_join(hd, gii, by = join_by)

str(human)

setwd("D:/New folder/OneDrive for Business 1/Git/IODS/IODS-project/data")
write.table(human, file = "human.txt", sep = " ", dec=".", row.names = FALSE, col.names = TRUE)

