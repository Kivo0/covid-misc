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
