
# imports
from sklearn.datasets import load_iris
import numpy as np

# load the test dataset
iris = load_iris()

# print the data
# print iris
# print iris.feature_names
# print iris.target_names

print('features: ' + str(iris['feature_names']))
print('labels: ' + str(iris['target_names']))

# print first row of data
print('first data row: ' + str(iris['data'][0]))
print('first target row: ' + str(iris['target'][0]))

# print all data
for i in range(len(iris['target'])) :
#    print("Example %d: label %s, features %s", %i, iris['target'][i])
    print("Example {}: label {}, features {}".format(i, iris['target_names'][iris['target'][i]], iris['data'][i]))
    

# get test data
test_index_array = [0, 50, 100]

# get the train data
train_target = np.delete(iris['target'], test_index_array)
train_data = np.delete(iris['data'], test_index_array, axis = 0)
for i in range(len(train_target)) :
    print("Train {}: label {}, features {}".format(i, iris['target_names'][train_target[i]], train_data[i]))
    

