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
