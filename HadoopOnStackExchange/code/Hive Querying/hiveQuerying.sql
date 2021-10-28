-- Create table usding the cleaned data by pig
create table posts(Id int, Score int, ViewCount int, Body String, OwnerUserId Int, Title String) 
row format delimited 
FIELDS TERMINATED BY ','
location '/assignment1/data/combined';

-- Setting to print table headers
SET hive.cli.print.header=true;

describe posts;

-- 1.Query the top 10 posts by score
SELECT id, title, score 
FROM posts
ORDER BY score DESC LIMIT 10;

-- 2.Query the top 10 users by post score
SELECT OwnerUserId, SUM(Score) AS TotalScore
FROM posts
GROUP BY OwnerUserId
ORDER BY TotalScore DESC LIMIT 10;

-- 3. Query the number of distinct users, who used the word 'cloud' in one of their posts
SELECT COUNT(DISTINCT OwnerUserId)
FROM posts
WHERE (body LIKE '%cloud%' OR title LIKE '%cloud%');
