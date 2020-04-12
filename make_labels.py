################################################################################################################################
################################################################################################################################
### Thomas Merkh, tmerkh@g.ucla.edu
### 4.12.2020
################################################################################################################################
################################################################################################################################
### This code reads in test_COVIDx.txt and train_COVIDx.txt and creates .mat files for the labels
### There are 3 classes, 0 == normal, 1 == COVID-19, 2 == pneumonia
################################################################################################################################
################################################################################################################################

import sys, os
import numpy as np
import scipy.io

cwd = os.getcwd()
testlabelfile = cwd + "/test_COVIDx.txt"
trainlabelfile = cwd + "/train_COVIDx.txt"
Save_loc = "/media/tmerkh/a18f683c-46a6-4846-aa3c-f47e5cfb8171"

f_test = open(testlabelfile,"r")
f_train = open(trainlabelfile,"r")

test_labels = []
train_labels = []
testerror = False
trainerror = False

lcount = 1
for line in f_test:
    label = line.split()[2]
    if(label == "normal"):
        test_labels.append(0)
    elif(label == "COVID-19"):
        test_labels.append(1)
    elif(label == "pneumonia"):
        test_labels.append(2)
    else:
        print("Unknown test label at line " + str(lcount))
        testerror = True
    lcount += 1
f_test.close()

lcount = 1
for line in f_train:
    label = line.split()[2]
    if(label == "normal"):
        train_labels.append(0)
    elif(label == "COVID-19"):
        train_labels.append(1)
    elif(label == "pneumonia"):
        train_labels.append(2)
    else:
        print("Unknown train label at line " + str(lcount))
        trainerror = True
    lcount += 1

f_train.close()

if(not trainerror):
    scipy.io.savemat(Save_loc + "/train_labels.mat", {"train_labels" : np.asarray(train_labels)})
if(not testerror):
    scipy.io.savemat(Save_loc + "/test_labels.mat", {"test_labels" : np.asarray(test_labels)})


if(not trainerror and not testerror):
    print("Program finished without error")
elif(trainerror):
    print("Program finished with an error in the training labels")
elif(testerror):
    print("Program finished with an error in the test labels")