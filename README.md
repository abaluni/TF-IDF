# pig_hive_TFIDF_assignment
This project takes data from data.stackexchange.com. Cleans the data with python and PIG. Gets the insights from data with use of HIVE. Lastly, it gives the details of TF-IDF for the top 10 users who have the highest total score in data.stackexchange.com data.

1.	Extracted the data from the StackExchange database using mysql commands Acquired the top 200,000 posts by viewcount.
# Website -- https://data.stackexchange.com/stackoverflow/query/edit/1125825
    #For selecting the range
    1. Select count(*) from posts where posts.ViewCount>112000 
    2. Select count(*) from posts where posts.ViewCount>66000 and posts.ViewCount < 112000
    3. select count(*) from posts where posts.ViewCount>47000 and posts.ViewCount < 66000
    4. select count(*) from posts where posts.ViewCount>36500 and posts.ViewCount < 47000

    # Query for downloading 50,000 unique records
    1.	select top 50000 * from posts where posts.ViewCount > 112000 ORDER BY posts.ViewCount
    2.	select top 50000 * from posts where posts.ViewCount>66000 and posts.ViewCount < 112000 ORDER BY posts.ViewCount
    3.	select top 50000 * from posts where posts.ViewCount>47000 and posts.ViewCount < 66000 ORDER BY posts.ViewCount
    4.	select top 50000 * from posts where posts.ViewCount>36500 and posts.ViewCount < 47000 ORDER BY posts.ViewCount

2.	4 files namely - QueryResults_1.csv, QueryResults_2.csv, QueryResults_3.csv, QueryResults_4.csv
3.	Above files’ linefeed (New lines) in Body, Title, Tags field were removed with the help of Pandas python code
    1.	Please refer clean_linefeed.py 
    2.	Cleaned files for linefeed were named as 1.csv, 2.csv, 3.csv, 4.csv
4.	Upload the cleaned files to Google Storage Bucket
5.	Create Directory “input” in HDFS file system to store input CVS file for processing
6.	Copy the files from Google Bucket to a folder of HDFS
7.	Run “PIG” commands in pig_data_cleaning.pig
    1.	PIG is used  extract, transform and load the data as applicable. 
    2.	Comma, HTML Tags, CSV Header rows were removed through PIG commands.
    3.	Rows where the OwnerUserId was NULL were removed and final data was stored as comma delimited values in transformation
8. 	Run “Hive” commands in hive_commands.txt in the zip folder to get the solution for Q3.i, Q3.ii, and Q3.iii 
9.	Refer hive_commands.txt to get the data for Top 10 users with highest score and dump that data to file for map-reduce processing and uploaded the final output table data in HDFS for map-reduce processing
10.	Execute the Map-Reduce commands (refer map-reduce-commands.txt) on the hive output table data for Top 10 users with highest score. (Mapper-Reducer code referred from https://github.com/devangpatel01/TF-IDF-implementation-using-map-reduce-Hadoop-python-)
11.	Combine the Map-Reduce output with $hdfs dfs -cat /user/mapred/output_4/part-* >> CombinedResult.txt  
12.	Run Pandas python commands (refer final_results.py) to display the calculation of per user TF-IDF 
