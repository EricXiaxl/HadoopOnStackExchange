-- Load four CSV files with cleaned data
csv1 = LOAD '/usr/assignment1/data/cleaned/cleaned_QueryResults1.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') AS (Id:int, PostTypeId:int,  AcceptedAnswerId:int, ParentId:int, CreationDate:chararray, DeletionDate:chararray, Score:int, ViewCount:int, Body:chararray, OwnerUserId:int, OwnerDisplayName:chararray, LastEditorUserId:int, LastEditorDisplayName:chararray, LastEditDate:chararray, LastActivityDate:chararray, Title:chararray, Tags:chararray, AnswerCount:int, CommentCount:int, FavoriteCount:int, ClosedDate:chararray, CommunityOwnedDate:chararray);
csv2 = LOAD '/usr/assignment1/data/cleaned/cleaned_QueryResults2.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') AS (Id:int, PostTypeId:int,  AcceptedAnswerId:int, ParentId:int, CreationDate:chararray, DeletionDate:chararray, Score:int, ViewCount:int, Body:chararray, OwnerUserId:int, OwnerDisplayName:chararray, LastEditorUserId:int, LastEditorDisplayName:chararray, LastEditDate:chararray, LastActivityDate:chararray, Title:chararray, Tags:chararray, AnswerCount:int, CommentCount:int, FavoriteCount:int, ClosedDate:chararray, CommunityOwnedDate:chararray);
csv3 = LOAD '/usr/assignment1/data/cleaned/cleaned_QueryResults3.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') AS (Id:int, PostTypeId:int,  AcceptedAnswerId:int, ParentId:int, CreationDate:chararray, DeletionDate:chararray, Score:int, ViewCount:int, Body:chararray, OwnerUserId:int, OwnerDisplayName:chararray, LastEditorUserId:int, LastEditorDisplayName:chararray, LastEditDate:chararray, LastActivityDate:chararray, Title:chararray, Tags:chararray, AnswerCount:int, CommentCount:int, FavoriteCount:int, ClosedDate:chararray, CommunityOwnedDate:chararray);
csv4 = LOAD '/usr/assignment1/data/cleaned/cleaned_QueryResults4.csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',', 'YES_MULTILINE','NOCHANGE','SKIP_INPUT_HEADER') AS (Id:int, PostTypeId:int,  AcceptedAnswerId:int, ParentId:int, CreationDate:chararray, DeletionDate:chararray, Score:int, ViewCount:int, Body:chararray, OwnerUserId:int, OwnerDisplayName:chararray, LastEditorUserId:int, LastEditorDisplayName:chararray, LastEditDate:chararray, LastActivityDate:chararray, Title:chararray, Tags:chararray, AnswerCount:int, CommentCount:int, FavoriteCount:int, ClosedDate:chararray, CommunityOwnedDate:chararray);

-- Combine the four CSV files
combinedCsv = UNION csv1,csv2,csv3,csv4;

-- Keep the required columns and replace the commas in 'Body' and 'Title'
filteredCsv = FOREACH combinedCsv GENERATE  Id AS Id, Score AS Score, ViewCount AS ViewCount, REPLACE(Body,',*','') AS Body, OwnerUserId AS OwnerUserId, REPLACE(Title,',*','') AS Title;

-- Filter out rows with NULL values in 'OwnerUserId' and 'Score'.
finalCsv = FILTER filteredCsv BY (OwnerUserId IS NOT NULL) AND (Score IS NOT NULL);

-- Save the final cleaned data to GCP HDFS
STORE finalCsv INTO 'hdfs://cluster-ca675-1-m/assignment1/data/combined' USING org.apache.pig.piggybank.storage.CSVExcelStorage(',');
