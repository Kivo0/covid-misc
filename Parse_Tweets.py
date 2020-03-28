################################################################################################################################
################################################################################################################################
### Thomas Merkh, tmerkh@g.ucla.edu
### 3.24.2020
################################################################################################################################
### 
### This code parses through hydrated tweets and preseves only a small fraction of the json information provided when fully hydrating tweets.
### In particular, it preserves the:
###     Text content of the tweet
###     Time and date it was created_at
###     The number of times it has been retweeted
### This file can save the user hundreds of Gbs of storage, at the cost of giving up everything but those fields.
### The program isn't hard to understand if one desires to retain more fields 
### 
################################################################################################################################
### To run this:  Be sure that the working file is indicating the correct file you'd like to append to the partially-hydrate tweets file
### If this isn't done correctly, then you'll end up with double or more of the same tweets. 
### 
################################################################################################################################
################################################################################################################################

import sys, os
import numpy as np
import scipy.io
import json

############################################ Program start ############################################ 
cwd = os.getcwd()
wd = cwd + "/Hydrated_Tweets"
files = [x[2] for x in os.walk(wd)][0]
working_file = wd + "/" + files[7]      # Switch this last number to parse different files
verbose = 0                             # 0 == no output, 1 == some output, 2 == full output (way too much for large files)

print(files)
print("Make sure you are appending the correct tweets onto the file so you do not double count any!")
print("When you have, remove the sys.exit() line and run the code")
print('Working file:', working_file)

sys.exit()


# Make sure that the directory already exists
if not(os.path.isdir(cwd + "/HydratedIDs_compressed")):
    print("Making folder containing file of partially hydrated Tweets")
    os.mkdir(cwd + "/HydratedIDs_compressed")

# Appending to the file! Important!
new_file = open(cwd + "/HydratedIDs_compressed/partial_tweets.json","a+")

counter = 0
with open(working_file) as f:
    for line in f:
        data = json.loads(line)   # Creates a dictionary out of each line, which is expected to be a json object

        # Restrict to only english data
        if(data['lang'] == 'en'):
            retained_data = dict()
            retained_data['full_text'] = data['full_text']
            retained_data['created_at'] = data['created_at']
            retained_data['retweet_count'] = data['retweet_count']

            if(verbose > 0):
                print(retained_data['created_at'])
                print(retained_data['full_text'])
                print(retained_data['retweet_count'])
                print('\n\n\n\n\n')
                if(verbose > 1):
                    print(json.dumps(retained_data, indent = 4, sort_keys=True))
            
            retained_json = json.dumps(retained_data)
            new_file.write(retained_json)
            new_file.write("\n")
            counter += 1

new_file.close()
print("Swifted through " + str(counter) + " tweets.  Program finished.")

# The data retained is about 1/30th of the size of the original files or less. 




""" DATA Exploration code:

        # if(data['lang'] != 'en'):
        #     print(data['full_text'])
        
        # if(data['is_quote_status']):
        #     print(data['full_text'])
        #     print(data['contributors'])
        #     print(data['in_reply_to_screen_name'])
        #     print(data['retweet_count'])
        #     print(data['source'])
        #     print('\n\n\n')
        


        if(data['retweet_count'] > 100):
            print('\n\n\n\n\n\n\n\n')
            # # Pretty Printing JSON string back
            print(json.dumps(data, indent = 4, sort_keys=True))
            print("Important stuff here:")
            print("Retweet count", data['retweet_count'], "\n")
            print("The full text is:", data['full_text'], "\n")
            print(data['is_quote_status'], "\n")
            print(data.keys())        # This shows the keys of the dictionar
            #print(data['full_text'])  # This is the tweet itself.  We could do a frequency count on key words now. 
            #print(data['created_at'].split()) # This contains the time and date of creation 
            # print(data['retweeted'])
            # print(data['retweet_count'])
            # print(data['favorited'])
            # print(data['lang'])

            # To get the URL for a given tweet that has been retweeted:
            # print()
            # if('media' in data['retweeted_status']['entities'].keys()):
            #     print(data['retweeted_status']['entities']['media'][0]['expanded_url'])
            # else:
            #     if('urls' in data['retweeted_status']['entities'].keys()):
            #         print("SOMETHING IS GOING ON HERE")
            #         print(data['retweeted_status']['entities']['urls'])
            #         if(len(data['retweeted_status']['entities']['urls']) > 0):
            #             print(data['retweeted_status']['entities']['urls'][0]['expanded_url'])
            #     else:
            #         print("HERE")
            #         print(data['retweeted_status']['entities'])
            counter += 1

        if(counter > 5):
            break

"""

"""
Keys for each json:

'contributors',
 'coordinates',
  'created_at',
   'display_text_range',
    'entities',
     'favorite_count',
      'favorited',
       'full_text',
        'geo',
         'id',
          'id_str',
           'in_reply_to_screen_name',
            'in_reply_to_status_id'
             'in_reply_to_status_id_str',
              'in_reply_to_user_id',
               'in_reply_to_user_id_str', 
                'is_quote_status',
                 'lang',
                  'place',
                   'retweet_count',
                    'retweeted',
                     'retweeted_status',
                      'source',
                       'truncated',
                         'user'
"""


"""
Things that I can do with this data.  

I can find popular tweets based on number of retweets
Ican search through tweets and find the word count frequency

Row : word
Column : date
Value = count

"""

""" 
Task now:
Clean the raw data so I can effeciently store it:

Retain entries:

coordinates
create at
full text 



https://programminghistorian.org/en/lessons/counting-frequencies
"""