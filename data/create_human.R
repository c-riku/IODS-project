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
colnames(hd)[7] <- "GNI"
colnames(hd)[8] <- "GNI.capita"

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


#Christine Ribeiro
#1.12.2018

setwd("D:/New folder/OneDrive for Business 1/Git/IODS/IODS-project/data")


human <- read.table(file = "human.txt",
                           header = TRUE,
                           dec = ".")

# Libraries
library(dplyr)
library(stringr)

# Data exploration and description

head(human)
str(human)
dim(human)
names(human)
summary(human)


#Description
#The dataset consists of several social-economical indicators from several countries.

#data.frame':	195 obs. of  19 variables:
#HDI.Rank   : Rank of the contry based on Human Development index (HDI)
#Country    : Name of country
#HDI        : Human Development index (the closer to 1 the better)
#expec.birth: Life Expectancy at Birth
#expec.edu  : Expected Years of Education 
#mean.edu   : Mean Years of Education
#GNI        : Gross National Income (GNI per Capita)
#GNI.capita : GNI per Capita (Rank Minus HDI Rank)
#GII.Rank   : Rank of the country based on Gender Inequality Index (GII)
#GII        : Gender Inequality Index
#mort.ratio : Maternal Mortality Ratio 
#adol.birth : Adolescent Birth Rate
#repres.par : Percent Representation in Parliament
#sec.eduF   : Female Population with Secondary Education
#sec.eduM   : Male Population with Secondary Education
#labF       : Female Labour Force Participation Rate
#labM       : Male Labour Force Participation Rate
#sec.edu    : Ratio of Female and Male populations with secondary education 
#lab.force  : Ratio of labour force participation of females and males

# Remove comma from GNI and mutate it to numeric (task 1)

human$GNI<- str_replace(human$GNI, pattern=",", replace ="")%>% as.numeric

str(human$GNI)


# Exclude unneeded variables (task 2)
keep <- c("Country", "sec.edu", "lab.force", "expec.birth", "expec.edu",
          "GNI", "mort.ratio", "adol.birth", "repres.par")

# select the 'keep' columns
human <- select(human, one_of(keep))


# Remove all rows with missing values (task 3)

colSums(is.na(human))
human <- na.exclude(human)

str(human)

# Remove the observations which relate to regions instead of countries (task 4)

tail(human, n=10)
human <- human[1:155, ]
tail(human, n=10)

# Add countries as rownames then remove it (task 5)

rownames(human) <- human$Country
human <- select(human, -Country)

write.table(human, file = "human.txt", sep = " ", dec=".", row.names = FALSE, col.names = TRUE)

