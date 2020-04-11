"""
This script creates matlab matrices which contain the learned representations of COVID-Net on several sources of X-ray data.
The data used here is exactly the data set outline in COVID-Net
The COVID-Net model(s) in use are the pretrained models supplied on the COVID-Net Github.  

For more information on the data set and network, see https://github.com/lindawangg/COVID-Net.

To run this file, clone the above github, place this file within the master directory, generate the dataset, and then run this program:
python feature_extract.py --weightspath <path_to_model> --metaname model.meta_train --ckptname model-2069 --imagepath assets/ex-covid.jpeg
"""

from sklearn.metrics import confusion_matrix
import numpy as np
import tensorflow as tf
from tensorflow import keras
import os, argparse
import cv2
import scipy.io

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='COVID-Net Feature Extraction')
    parser.add_argument('--weightspath', default='output', type=str, help='Path to output folder')
    parser.add_argument('--metaname', default='model.meta', type=str, help='Name of ckpt meta file')
    parser.add_argument('--ckptname', default='model', type=str, help='Name of model ckpts')
    parser.add_argument('--testfile', default='test_COVIDx.txt', type=str, help='Name of testfile')
    parser.add_argument('--trainfile', default='train_COVIDx.txt', type=str, help='Name of train file')
    parser.add_argument('--testfolder', default='test', type=str, help='Folder where test data is located')
    parser.add_argument('--trainfolder', default='train', type=str, help='Folder where training data is located')
    parser.add_argument('--imagepath', default='assets/ex-covid.jpeg', type=str, help='Full path to image to be inferenced')
    parser.add_argument('--datadir', default='data', type=str, help='Path to data folder')

    args = parser.parse_args()

    sess = tf.Session()
    tf.get_default_graph()
    saver = tf.train.import_meta_graph(os.path.join(args.weightspath, args.metaname))
    saver.restore(sess, os.path.join(args.weightspath, args.ckptname))
    graph = tf.get_default_graph()

    with open(args.trainfile) as f:
        trainfile = f.readlines()
    with open(args.testfile) as f:
        testfile = f.readlines()


    if(False):
        # Gets all trained variables 
        trainable = tf.get_collection(tf.GraphKeys.TRAINABLE_VARIABLES)
        for item in trainable:
            print(item)

    if(False):
        ## Gets all tensors in this graph
        all_names = [op.name for op in graph.get_operations()]
        for name in all_names:
            print(name)

        image_tensor = graph.get_tensor_by_name("input_1:0")
    representation_tensor = graph.get_tensor_by_name("flatten_1/Reshape:0") # pre-activation for 100352 dense layer
    
    ## testfile or trainfile can be used
    ## trainfile is so large that the process will get killed if not enough memory is available (I think its about 11Gbs)
    if(False):
        file = trainfile
        folder = args.trainfolder
    else:
        file = testfile
        folder = args.testfolder

    #This network produces 2024 7x7 patches at the final layer which gets flattened into 100352 1D vector.
    covidnet_reps = np.zeros((len(file),100352))  # Right now, I've hard coded in this value 100352.
    
    # For generating the representations learned on either the test set or training set
    if(True):
        for i in range(len(file)):
            line = file[i].split()
            x = cv2.imread(os.path.join('data', folder, line[1]))
            x = cv2.resize(x, (224, 224))
            x = x.astype('float32') / 255.0
            output = sess.run(representation_tensor, feed_dict={image_tensor: np.expand_dims(x, axis=0)})
            covidnet_reps[i][:] = output[0]

    ## For a single input specified with --imagepath
    if(False):
        x = cv2.imread(args.imagepath)
        x = cv2.resize(x, (224, 224))
        x = x.astype('float32') / 255.0
        output = sess.run(representation_tensor, feed_dict={image_tensor: np.expand_dims(x, axis=0)})
        print("The image at " + str(args.imagepath) + " has representation:")
        print(output[0])
        
    print("Saving Representations")
    scipy.io.savemat("covidnet_reps.mat", {"covidnet_reps" : covidnet_reps})