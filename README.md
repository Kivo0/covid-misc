# covid
Contains some codes for gathering, cleaning, and analyzing COVID19 data.  Data sources are various, including but not limited to Twitter, NYtimes, and Plague.com.

The files contained are related to two different areas:

Twitter data:
Merge_TweetIDs.py - This script was made to ease the process of Hydrating tweet ID data by merging tweetIDs into large text files.  The user may pick the number of tweetIDs per file. I have chosen 1 million IDs/file, which takes approximately 4-5 hours to hydrate.

Parse_Tweets.py - This script sifts through hydrated tweets and can be used to retain only the important parts of the hydrated tweets, such as the 'full_text', number of retweets, and so on.  Currently, it retains only tweets marked to be in the english language.  This lowers the storage requirement for the twitter data, and speeds up the following script. 

Construct_Library_Matrix.py - This script iterates through the retained twitter data from the previous script and constructs a MATLAB matrix where 

Each row is indexed by a user-chosen buzzword, like "coronavirus" or "masks"
Each column is indexed by a date (Jan 22, Jan 23, ...)
Each value corresponds to the instances of the given word on the diven date

The user can specify an arbitrary number of words to search for in the tweet data.  

plot_tweets.m - This MATLAB (Octave) script is just a generic script for plotting several words of interest from the matrix constructed by the previous program.  Specifically, it is written to plot the relative frequency of each word.  See file header for a longer description. 

Time Series data:
Create_Matrix.py - Creates MATLAB matrices from "messy" time series data.  See file header for full description and where the data comes from.

plot_timeseries.m - The plotting utility for Create_Matrix.py

See https://www.math.ucla.edu/~tmerkh/ for some of the plots produced using these files.


X-Ray data:

Extract_COVIDnet_Features.py - This script can be used to extract the learned representations of COVID-Net on the data set described in https://github.com/lindawangg/COVID-Net.  For more information about COVID-Net or the data set, please see the listed Github.

make_labels.py - This script reads the test_COVIDx.txt and train_COVIDx.txt files generated along with the data set and creates MATLAB files containing labels where 0 == healthy, 1 == COVID-19, 2 == pneumonia.

kmeans_COVIDnet_Representations.m - This script performs kmeans on the representation of the data learned at the final layers of COVID-Net.  Additionally, it includes a short adaptable code for PCA.

kmeans_DenseNet_Representations.m - This script is the same as the previous but adjusted forclustering the learned representations at the final layers of DenseNet.
