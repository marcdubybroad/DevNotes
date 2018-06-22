import tensorflow as tf
hello = tf.constant('Hello TF script!')
sess = tf.Session()
print(sess.run(hello).decode())

