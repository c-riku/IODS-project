#Task 2

# libraries
library(MASS)
library(corrplot)
# load the data
data("Boston")

# Structure and dimension
str(Boston)
dim(Boston)
head(Boston)

# Description

#Task 3
cor_matrix<-cor(Boston)
corrplot(cor_matrix,type="upper")
# According to the correlation matrix, the strongest correlations were:
#- mean of distances to five Boston employment centres negatively correlates (-0.75) with proportion of owner-occupied units built prior to 1940;
#- mean of distances to five Boston employment centres negatively correlates (-0.77) with nitrogen oxides concentration;
#- mean of distances to five Boston employment centres negatively correlates (-0.71) proportion of non-retail business acres per town;
#- median value of owner-occupied homes in \$1000s negatively correlates (-0.74) with lower status of the population;
#- median value of owner-occupied homes in \$1000s positively correlates (0.7) with average number of rooms per dwelling;
#- full-value property-tax rate per \$10,000 positively correlates (0.91) with index of accessibility to radial highways;
#- full-value property-tax rate per \$10,000 positively correlates (0.72) with proportion of non-retail business acres per town;
#- proportion of owner-occupied units built prior to 1940 positively correlates (0.73) with nitrogen oxides concentration (parts per 10 million);

#Task 4

boston_scaled <- scale(Boston)
summary(boston_scaled)
summary(Boston)

#The means are 0, and the min. and max. (range) are a lot smaller in absolute values. 

# create a quantile vector of crim and print it
bins <- quantile(boston_scaled[,1])

# create a categorical variable 'crime'
crime <- cut(boston_scaled[,1], breaks = bins, include.lowest = TRUE, label=c("low","med_low","med_high","high"))

# look at the table of the new factor crime
table(crime)

# add the new categorical value to scaled data
boston_scaled <- data.frame(boston_scaled, crime)

# number of rows in the Boston dataset 
n <- nrow(boston_scaled)

# choose randomly 80% of the rows
ind <- sample(n,  size = n * 0.8)

# create train set
train <- boston_scaled[ind,]

# create test set 
test <- boston_scaled[-ind,]

# save the correct classes from test data
correct_classes <- test$crime

# remove the crime variable from test data
test <- dplyr::select(test, -crime)

str(train)
str(test)

#Task 5 and 6

# linear discriminant analysis
lda.fit <- lda(crime~., data = train)

# print the lda.fit object
lda.fit

# the function for lda biplot arrows
lda.arrows <- function(x, myscale = 1, arrow_heads = 0.1, color = "red", tex = 0.75, choices = c(1,2)){
  heads <- coef(x)
  arrows(x0 = 0, y0 = 0, 
         x1 = myscale * heads[,choices[1]], 
         y1 = myscale * heads[,choices[2]], col=color, length = arrow_heads)
  text(myscale * heads[,choices], labels = row.names(heads), 
       cex = tex, col=color, pos=3)
}

# target classes as numeric
classes <- as.numeric(train$crime)

# plot the lda results
plot(lda.fit, dimen = 2, col=classes,pch=classes)
lda.arrows(lda.fit, myscale = 1.5)


# predict classes with test data
lda.pred <- predict(lda.fit, newdata = test)

# cross tabulate the results
table(correct = correct_classes, predicted = lda.pred$class)

#Task 7

boston_scaled2 <- scale(Boston)
summary(boston_scaled2)

# euclidean distance matrix
dist_eu <- dist(boston_scaled2,method="euclidean")

# look at the summary of the distances
summary(dist_eu)

# calculate the total within sum of squares
twcss <- sapply(1:10, function(k){kmeans(boston_scaled2, k)$tot.withinss})

# visualize the results
qplot(x = 1:10, y = twcss, geom = 'line')

# k-means clustering
km <-kmeans(boston_scaled2, centers = 2)

# plot the Boston dataset with clusters
pairs(boston_scaled2, col = km$cluster)

#According to k-means clustering, the observations of all covariates included in the Boston dataset are somehow clustered in two heterogeneous samples




