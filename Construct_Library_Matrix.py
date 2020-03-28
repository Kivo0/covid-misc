################################################################################################################################
################################################################################################################################
### Thomas Merkh, tmerkh@g.ucla.edu
### 3.24.2020
################################################################################################################################
### 
### This code parses through tweet json files, searches through the full text content of each tweet, and constructs a matrix with
###     Rows = Key words, like coronavirus
###     Cols = Dates
###     Values = Number of instances of a given word 
### 
################################################################################################################################
### To run this:  
###     Word_Library = list of all words the user would like to search through in the tweet data
###     
###
################################################################################################################################
################################################################################################################################

import sys, os
import numpy as np
import scipy.io
import json
import string

def determine_date(tweet_time):
    # Takes in a tweet's created_at field split into a list
    # Returns the date of the tweet
    date = 0
    if(tweet_time[1] == 'Feb'):
        date += 31
    elif(tweet_time[1] == 'Mar'):
        date += 29+31 # 2020 was a leap year
    elif(tweet_time[1] == 'Apr'):
        date += 31+29+31
    elif(tweet_time[1] == 'May'):
        date += 31+29+31+30
    date += int( tweet_time[2] )
    return date

####################################################################################################### 
############################################ Program start ############################################ 
#######################################################################################################

#######################################################################################################
######################################## User Defined Params ##########################################
#######################################################################################################

# Define the words which we would like to count throughout the data
word_library = ['pandemic','covid19','covid-19','coronavirus','china','wuhan','wuhanvirus','trump','stimulus','economy','health','hospital','hospitals','distancing','social','america','americas','europe','italy','spain','france','germany','chinavirus','racist','shelter','medical','epidemic','pence','markets','fauci','right-wing','left-wing','democrats','republicans','asian','asia','panic','fake','closure','schools','universities','university','symptoms','cough','lungs','dead','dying','die','recovered','restrictions','recession','ventilators','respiratory','masks','mask','gloves','ppe', 'protective','stayathome','trumpmadness','safehands','viewfrommywindow','mypandemicsurvivalplan','quarantineandchill','flu','usa','corona','panic-building','students','cdc','canceled','cancelled','crisis','tests','test','god','sanitizer','research','toilet']

#######################################################################################################
#################### Don't Mess with below unless you know what you're doing ##########################
#######################################################################################################

wrd_set = set(word_library)
word_dict = {key: 0 for key in word_library} 
if(len(word_library) != len(word_dict.keys())):
    word_library = list(wrd_set)
    print("There are repeat words in the library!\n The ordering of the word_library may be changed,\n but this will be reflected in the saved files.")
    if(len(word_library) != len(word_dict.keys())):
        print("Something is going wrong.  Exiting program...")
        sys.exit()


cwd = os.getcwd()
#wd = cwd + "/Hydrated_Tweets"           # if using full tweets
wd = cwd + "/HydratedIDs_compressed"     # if using the partial tweet json files for better storage, and which are english-only
files = [x[2] for x in os.walk(wd)][0]
verbose = 0                              # 0 == no output, 1 == some output

dates = set()
dates_instances = dict()
counter = 0

print("Finding the date range in the currently hydrated tweet data. This may take a minute.")
for q in range(len(files)):
    working_file = wd + "/" + files[q]
    print("Finding relevant dates from file number", q+1, "of", len(files))
    with open(working_file) as f:
        for line in f:
            data = json.loads(line)   # Creates a dictionary out of each line, which is a json object
            date = determine_date(data['created_at'].split())
                    
            if(date not in dates):
                dates_instances[str(date)] = 1
            else:
                dates_instances[str(date)] += 1
            dates.add(date)
            counter += 1

dates = list(dates)
dates.sort()

# need to fill out gaps in dates since data may be missing from some dates
for i in range(dates[0],dates[-1]+1):
    if(str(i) not in dates_instances.keys()):
        dates_instances[str(i)] = 0

if(verbose > 0):
    print(dates)
    print(dates_instances)

date_range = dates[-1] - dates[0] + 1

# Create a numpy array which has size len(word_library) by XXXlen(dates)XXX date_range since some dates are missing, its values will be occurences of each word on a given date
Lib_Mat = np.zeros((len(word_library),date_range))

print("Counting word instances from tweet data. This typically takes about 1-5 minutes per million tweets.")
counter = 0
first_day = dates[0]
for q in range(len(files)):
    working_file = wd + "/" + files[q]
    print("Counting word instances from file number", q+1, "of", len(files))
    with open(working_file) as f:
        for line in f:
            data = json.loads(line)   # Creates a dictionary out of each line, which is a json object
            content = data['full_text'].lower().split()
            content = [s.translate(str.maketrans('', '', string.punctuation)) for s in content] # Strips all punctuation from strings

            date = determine_date(data['created_at'].split())
            date = date - first_day # Now dating starts from zero, so they can serve as indices for the Lib_Mat matrix

            for j in range(len(content)):
                # Counts the total instances of words
                # Adds them to the according column/row of the matrix
                if(content[j] in wrd_set):
                    word_dict[content[j]] += 1
                    Lib_Mat[word_library.index(content[j])][date] += 1

            counter += 1

if(verbose > 0):
    print(Lib_Mat)
    print(word_dict)


# Make sure that the save directory already exists
if not(os.path.isdir(cwd + "/Word_Library_Matrix")):
    print("Making folder containing files associated with the word library matrix")
    os.mkdir(cwd + "/Word_Library_Matrix")


# Output
filename = "Library_Matrix2"

new_file = open(cwd + "/Word_Library_Matrix/" + filename + "_rowinfo.txt","w+")
new_file.write("The words and total number of instances of each:\n")
new_file.write(json.dumps(word_dict))
new_file.write("\n")
new_file.write(str(list(word_dict.values())))
new_file.write("\n")
new_file.write("The ordered list showing which column corresponds to which word, indexing starts at 1\n")
for l in range(len(word_library)):
    new_file.write(str(l+1) + " : " + word_library[l] + "\n")
new_file.close()


new_file = open(cwd + "/Word_Library_Matrix/" + filename + "_colinfo.txt","w+")
new_file.write("The dates and total number of tweets during each:\n")
new_file.write(json.dumps(dates_instances))
new_file.write("\n")
new_file.write(str(list(dates_instances.values())))
new_file.write("\n")
new_file.write("The ordered list showing which column corresponds to which date (day of the year with Jan 1 == 1), indexing starts at 1\n")
for l in range(len(dates)):
    new_file.write(str(l+1) + " : " + str(dates[l]) + "\n")
new_file.close()

# For some reason, this only works if the working directory is the same as the save location
os.chdir(cwd + '/Word_Library_Matrix')
scipy.io.savemat(filename + ".mat", {filename : Lib_Mat})
scipy.io.savemat(filename + "row_count.mat", {filename+"row_count" : np.asarray(list(word_dict.values()))})
scipy.io.savemat(filename + "col_count.mat", {filename+"col_count" : np.asarray(list(dates_instances.values()))})
os.chdir('..')

print("Program Finished and Output Written to current directory")