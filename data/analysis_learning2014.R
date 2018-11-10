setwd("D:/New folder/OneDrive for Business 1/Git/IODS/IODS-project/data")

learning2014 <- read.table(file = "learning2014.txt",
                           header = TRUE,
                          dec = ".")
#Exploration 
dim(learning2014)
str(learning2014)

#the relationship between learning approaches and students achievements in
#an introductory statistics course in finland
#learning approaches were attitude, deep, strategic, and surface knowledge, and achiviements measured in points
#surveys divided by gender (M, F)
#age recorded


library(GGally)
library(ggplot2)

p <- ggpairs(learning2014, mapping = aes(col=gender, alpha=0.3), lower = list(combo = wrap("facethist", bins = 20)))
#Gender is unbalaned, more males were sampled. 
#The age of male respondents has wider range
#Possible linear relationship between points and attitude
#Possible exponential relatonship between points and stra
#Points seem to vary with gender
#Maybe attitude and stra are collinear with gender

#Analysis
my_model <- lm(points ~  attitude + stra + surf, data = learning2014)
summary(my_model)

#According to the model, attitude has a positive effect on points, stra has a non significant effect on points,
#whereas surf has a non significant negative effect on points. Therefore, stra and surf do not seem to contribute
#to the prediction of points and can be removed from the model

my_model2 <- lm(points ~  attitude , data = learning2014)
summary(my_model2)
#Points= 11.6 + 3.5*attitude + noise
#Points are increased on average 3.5 units per unit of change in attitude
#In a scale of 0-100%, attitude explains about 18.6% of the variance in points. It's very little.


#Validation
par(mfrow = c(2,2))
plot(my_model2, which =c(1,2,5))
#Normality of the errors - There's deviation from the line, making errors not normally distributed
#Constant varaince of errors - size of residuals decreases towards the end when fitted values increase
#Leverage - A couple of observations stand out from the rest (71, 35)


