
# from video https://www.youtube.com/watch?v=FtKUj0icUz4&t=960s

# imports
import tensorflow as tf
from tensorflow import keras
import numpy as np


# sequential NN of a single 1D node
model = keras.Sequential([keras.layers.Dense(untis=1, input_shape=[1])])

# stochatic gradient descent will guess the y = Mx + N params
# MSE will be the error mesurment
model.compile(optimizer = 'sgd', loss = 'mean_squared_error')


xs = np.array([-1.0, 0.0, 1.0, 2.0, 3.0, 4.0], dtype = float)
ys = np.array([-3.0, -1.0, 1.0, 3.0, 5.0, 7.0], dtype = float)

# fit the model, 500 loops to guess
model.fit(xs, ys, epochs = 500)


# infer
# don't get 19 result since uncertainty always maintained that the line might not include all points
print(model.predict([10.0]))

