library(ISLR)
library(tidyverse)
library(viridis)
library(ggthemes)

#######################
### IMPORT THE DATA ###
#######################
# We will use the College dataset that is include witin the ISLR package

df <- College

########################
### EXPLORE THE DATA ###
########################

head(df)
str(df)


########################
### EXPLORE THE DATA ###
########################


ggplot(df, aes(x = Room.Board, y = Grad.Rate)) +
    geom_point(aes(color = Private), alpha = .5, size = 2) +
    geom_smooth(method = lm, se = FALSE, color = 'red', size = .5) +
    theme_clean()

ggplot(df, aes(F.Undergrad)) +
    geom_histogram(aes(fill = Private), color = 'black', bins = 50, alpha = .5) +
    theme_bw()

ggplot(df, aes(Grad.Rate)) +
    geom_histogram(aes(fill = Private), color = 'black', bins = 50, alpha =0.6) +
    theme_bw()

subset(df, Grad.Rate > 100)

df['Cazenovia College', 'Grad.Rate'] <-  100

library(caTools)
sample <- sample.split(df$Private, SplitRatio = 0.7)
train <- subset(df, sample == TRUE)
test <- subset(df, sample == FALSE)

library(rpart)
library(rpart.plot)
tree <- rpart(Private ~ ., method = 'class', data = train)
prp(tree)

#####
## TRAIN MODEL
#####

tree.prediction <- predict(tree, test)
head(tree.prediction)

#####
# Turn these two columns into one column to match the original Yes/No Label for a Private column. 

tree.prediction <- data.frame(tree.prediction)

# First, save tree.predictions as a data frame. Next create a function to iteritivally look over the data fra, and return yes is it is greater than .5 and No if it is less that. 

joiner <- function(x){
    if (x > 0.5) {
        return('Yes')
    }else{
        return('No')
    }
}
#####
# Next to create a new column in the test.prediction data frame assign the sapply function to the variable tree.prediction$Private. 

tree.prediction$Private <- sapply(tree.prediction$Yes, joiner)
head(tree.prediction)

table(tree.prediction$Private, test$Private)
prp(tree)
summary(tree)
#####
## RANDOM FOREST
#####

library(randomForest)

randomForest.model <- randomForest(Private ~ ., data = train, importance = TRUE)

randomForest.model$confusion # Based on training data
randomForest.model$importance
p <- predict(randomForest.model, test)

table(p, test$Private)
