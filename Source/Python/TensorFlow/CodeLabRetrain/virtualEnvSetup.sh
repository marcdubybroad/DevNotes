
# install virtual env using anaconda
conda install virtualenv
which virtualenv
python

# create the TF virtual environment, specifying directory where the config will be stored
virtualenv --system-site-packages ~/Apps/PythonEnvs/TensorFlow01

# activate the envisonment
source ~/Apps/PythonEnvs/TensorFlow01/bin/activate

# use pip install packages within the virtual environment
which pip
easy_install -U pip
pip -version
pip -V
pip install --upgrade tensorflow

# get to work on TF
# clone TF
git clone https://github.com/googlecodelabs/tensorflow-for-poets-2 TensorFlowPoets02

# get the model to work on
curl http://download.tensorflow.org/example_images/flower_photos.tgz | tar xz -C tf_files

# set the model for retraining (224px image size, 1/2 of mobile net )
IMAGE_SIZE=224
ARCHITECTURE="mobilenet_0.50_${IMAGE_SIZE}"

# launch tensorblard monitoring tool
tensorboard --logdir tf_files/training_summaries &
# to clean, do below
# pkill -f "tensorboard"

# read help on the retrain script
python -m scripts.retrain -h


# retrain command
python -m scripts.retrain \
  --bottleneck_dir=tf_files/bottlenecks \
  --how_many_training_steps=500 \
  --model_dir=tf_files/models/ \
  --summaries_dir=tf_files/training_summaries/"${ARCHITECTURE}" \
  --output_graph=tf_files/retrained_graph.pb \
  --output_labels=tf_files/retrained_labels.txt \
  --architecture="${ARCHITECTURE}" \
  --image_dir=tf_files/flower_photos


# help for the label image script
python -m  scripts.label_image -h

# run the labe script
python -m scripts.label_image \
    --graph=tf_files/retrained_graph.pb  \
    --image=tf_files/flower_photos/daisy/21652746_cc379e0eea_m.jpg

python -m scripts.label_image \
    --graph=tf_files/retrained_graph.pb  \
    --image=tf_files/flower_photos/roses/2414954629_3708a1a04d.jpg


# less trainig rate, with seperate summaries directory
python -m scripts.retrain \
  --bottleneck_dir=tf_files/bottlenecks \
  --how_many_training_steps=550 \
  --model_dir=tf_files/models/ \
  --summaries_dir=tf_files/training_summaries/"${ARCHITECTURE}_LR_0.5" \
  --output_graph=tf_files/retrained_graph.pb \
  --output_labels=tf_files/retrained_labels.txt \
  --architecture="${ARCHITECTURE}" \
  --image_dir=tf_files/flower_photos

