##### Tree-based methods for regression and classification. These involve stratifying or segmenting the predictor space into a number of simple regions. In order to make a prediction for a given observation, we typically use the mean or the mode of the training observa- tions in the region to which it belongs. Since the set of splitting rules used to segment the predictor space can be summarized in a tree, these types of approaches are known as decision tree methods.  Cover Bagging, random forests, and boosting. Each of these approaches involves producing multiple trees which are then combined to yield a single consensus prediction. We will see that combining a large number of trees can often result in dramatic improvements in prediction accuracy, at the expense of some loss in inter- pretation.

#### Bootstrap: taking repeated samples from the (single) training data set. You can generate a number of bootstrapped training sets and average all the predictions this is called bagging. While bagging can improve predictions for many regression methods, it is particularly useful for decision trees. To apply bagging to regression trees, we simply construct B of regression trees using B bootstrapped training sets, and average the resulting predictions. These trees are grown deep, and are not pruned. Hence each individual tree has high variance, but low bias. Averaging these B trees reduces the variance. Bagging has been demonstrated to give impressive improvements in accuracy by combining together hundreds or even thousands of trees into a single procedure.

### Random Forest a process that decorrelates trees, by forcing each split to consider only a subset of the predictors. Therefore on average of the splits will not even consider the strong predictor and so other predictors will have more of a chance, thereby making the average of the resulting trees less variable and hence more reliable. The main difference between bagging and random forests is the choice of predictor subset size m. 

### Boosting: We now discuss boosting, yet another approach for improving the predic- tions resulting from a decision tree. Like bagging, boosting is a general approach that can be applied to many statistical learning methods for re- gression or classification. Recall that bagging involves creating multiple copies of the original train- ing data set using the bootstrap, fitting a separate decision tree to each copy, and then combining all of the trees in order to create a single predic- tive model. Notably, each tree is built on a bootstrap data set, independent of the other trees. Boosting works in a similar way, except that the trees are grown sequentially: each tree is grown using information from previously grown trees. Boosting does not involve bootstrap sampling; instead each tree is fit on a modified version of the original data set. Note that in boosting, unlike in bagging, the construction of each tree depends strongly on the trees that have already been grown.

library(rpart)

help("rpart")

str(kyphosis)
head(kyphosis)

tree <- rpart(Kyphosis ~ ., method = 'class', data = kyphosis)
printcp(tree)
plot(tree, uniform = T, main = 'Kyphosis Tree')
text(tree, use.n = T, all = T)

# Better looking decsion tree
library(rpart.plot)
prp(tree)

### Random forest
help("randomForest")
library(randomForest)
# First arguement is Kyphosis (notice the capital because it is the column name)
rf.model <- randomForest(Kyphosis ~ . , data = kyphosis)
rf.model

# Values
rf.model$predicted
rf.model$ntree
rf.model$confusion
rf.model$votes
