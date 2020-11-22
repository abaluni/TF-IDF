-- Register and Define piggybank.jar to load the CSV
REGISTER /usr/lib/pig/piggybank.jar;
DEFINE CSVExcelStorage org.apache.pig.piggybank.storage.CSVExcelStorage;

-- Load the data from HDFS location using CSVExcelStorage and comma as a delimiter and allowig Multiline text and skipping input headers
load_data = LOAD '/user/pig/input/' USING CSVExcelStorage(',', 'YES_MULTILINE', 'UNIX','SKIP_INPUT_HEADER');

-- Remove commas from Body, Title, and Tags text
clean_comma = FOREACH load_data GENERATE $1 as Id, $7 as Score, REPLACE($9, ',', '') AS Body, $10 AS OwnerUserId, REPLACE($16, ',', '')  AS Title, REPLACE($17, ',', '') AS Tags;

-- Remove HTML tags from the Body, Title, and Tags text
clean_tags = FOREACH clean_comma GENERATE Id, Score, REPLACE(Body, '<.*?>',' ') AS Body, OwnerUserId, REPLACE(Title, '<.*?>',' ')  AS Title, REPLACE(Tags, '<.*?>', ' ') AS Tags;

-- Remove the headers that were in CSV file
skip_header_data = FILTER clean_tags BY $2 != 'Body';

-- Remove the row data where owneruserid is NULL
final_data = FILTER skip_header_data BY OwnerUserId!='';

-- Store the data using PigStorage as comma delimited values on HDFS.
STORE final_data INTO '/user/pig/output2' USING PigStorage(',');
