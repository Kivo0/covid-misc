################################################################################################################################
################################################################################################################################
### Thomas Merkh, tmerkh@g.ucla.edu
### 3.24.2020
################################################################################################################################
### 
### This code gathers Tweet IDs from the data found at https://github.com/echen102/COVID-19-TweetIDs in seperate files and 
### combines them into files containing a specified number of  tweets/file.  
### 
################################################################################################################################
### To run this:  This program assumes that it is being held in the directory directly above the "2020-01", "2020-02" files.
### If the program is in the correct directory, then simply run the file.
### The one place where something *could* go wrong is if there exist "unexpected" sub-directories, 
### particularly directories which end in integers and do not contain tweet IDs.
################################################################################################################################
################################################################################################################################

import sys, os
import numpy as np
import scipy.io

### User Defined Parameter(s) ###
N_Ids = 1000000 # How many Tweet IDs to merge into a single file. 


############################################ Program start ############################################ 
cwd = os.getcwd()
directories = [x[0] for x in os.walk(cwd)][1:]
directories = sorted(directories)

# Need to remove the folders which do not contain the hourly Tweet ID's
items_to_remove = []
for folder in directories:
    try:
        int(folder[-2:])
    except ValueError:
        items_to_remove.append(folder)

for folder in items_to_remove:
    directories.remove(folder)

# Check if the combined txt file already has been made.
if not(os.path.isfile(cwd + "/combined.txt")):
    print("Making combined text, this may take several minutes")
    f = open("combined.txt","w")
    
    for i in range(len(directories)):
        os.chdir(directories[i])
        local_directory_files = os.listdir(directories[i])
            
        for j in range(len(local_directory_files)):
            file = open(local_directory_files[j], "r") 
            for line in file:  
                f.write(line)
        
        os.chdir('..')
    f.close()

# At this point, I have it going through every single file and writting it all to one HUGE combined.txt file.
# The tweet IDS in this file are ordered by time, so they are sequential.

# Now I want to break this into text files containing N_Ids Tweet IDs
# The method: With the combined text file: counter = 0, if(counter == 0) create file, 
# if counter == N_Ids-1 close file, set counter to 0, open file, etc. 
# Each text file will be 2Mb in size per 100,000 Tweet IDs
# After hydrating, 100,000 tweets will be approximately 600 Mbs.


if not(os.path.isdir(cwd + "/DehydratedIDs")):
    print("Making folder containing files of " + str(N_Ids) + " Tweet IDs, to be hydrated")
    os.mkdir(cwd + "/DehydratedIDs")

file_counter = 1
counter = 0
print("Creating files containing " + str(N_Ids) + " Tweet IDs each")
with open("combined.txt") as f:
    for line in f:
        if(counter == 0):
            q = open("DehydratedIDs/tweets" + str(file_counter) + ".txt","w")
            file_counter += 1 
    
        if(counter < N_Ids):
            q.write(f.readline())
            counter += 1
    
        elif(counter == N_Ids):
            counter = 0
            q.close()

print("Program finished")
############################################ Program finished ############################################
