

# this scriipt is from the first video of Siraj's intro to Python ML series
# https://www.youtube.com/watch?v=T5pRlIbr6gg&index=2&list=PL2-dafEMk2A6QKz1mrk1uIGfHkC1zZ6UU&t=0s

# import
from sklearn import tree

# build the person model; this will determine whether a person is male/female
# [height, weight, shoe size] features
X = [[181, 80, 44], [177, 70, 43], [160, 60, 38], [154, 54, 37], [166, 65, 40], [190, 90, 47], [175, 64, 39],
    [177, 70, 40], [171, 75, 42], [181, 85, 43]]

# labels
Y = ['male', 'female', 'female', 'female', 'male', 'male', 'male', 'female', 'female', 'male']

# get the clssifier
classifier = tree.DecisionTreeClassifier()

# train the model
classifier.fit(X, Y)

# do a prediction
predictionInput = [190, 70, 43]
prediction = classifier.predict(predictionInput)

# print the prediction
print("the prediction for input {} is {}".format(predictionInput, prediction))



