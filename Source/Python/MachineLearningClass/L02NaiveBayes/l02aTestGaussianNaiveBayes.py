
import numpy as np

# 6 2d points of features
X = np.array([[-1, 1], [-2, -1], [-3, -2], [1, 1], [2, 1], [3, 2]])

# 6 labels
Y = np.array([1, 1, 1, 2, 2, 2])

# bring in extrenal module
from sklearn.naive_bayes import GaussianNB

# create classifier
clf = GaussianNB()

# fit/train the classifier, with features X and labels Y
# lear the patterns
clf.fit(X, Y)

# predict new point, and predict lahel
print(clf.predict([[-0.8, -1]]))

