-- Store top ten users in 'TopTenUsers' table:

CREATE TABLE TopTenUsers
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ',' AS
SELECT OwnerUserId, SUM(Score) AS TotalScore
FROM posts
GROUP BY OwnerUserId
ORDER BY TotalScore DESC LIMIT 10;

-- Using OwnerUserId from TopTenUsers to query the top ten user's all of the posts' Body and Title, and stored in 'TopTenUserPosts' table. 

CREATE TABLE TopTenUserPosts AS
SELECT OwnerUserId, Body, Title
FROM posts
WHERE OwnerUserId in (SELECT OwnerUserId FROM TopTenUsers)
GROUP BY OwnerUserId, Body, Title;

-- Store the TopTenUserPosts results into HDFS location

INSERT OVERWRITE DIRECTORY '/assignment1/data/results'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT OwnerUserId, Body, Title
FROM TopTenUserPosts
GROUP BY OwnerUserId, Body, Title;