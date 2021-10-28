-- figure out range
SELECT COUNT(*) FROM posts WHERE posts.ViewCount > 40000；

-- first query 
Select TOP 50000 * 
FROM posts 
Where posts.ViewCount > 40000 and (Id NOT IN (Select TOP 0 Id FROM posts order by posts.ViewCount DESC))
order by posts.ViewCount DESC;

-- second query
Select TOP 50000 * 
FROM posts 
Where posts.ViewCount > 40000 and (Id NOT IN (Select TOP 50000 Id FROM posts order by posts.ViewCount DESC))
order by posts.ViewCount DESC;

-- third query
Select TOP 50000 * 
FROM posts 
Where posts.ViewCount > 40000 and (Id NOT IN (Select TOP 100000 Id FROM posts order by posts.ViewCount DESC))
order by posts.ViewCount DESC;

-- fourth query
Select TOP 50000 * 
FROM posts 
Where posts.ViewCount > 40000 and (Id NOT IN (Select TOP 150000 Id FROM posts order by posts.ViewCount DESC))
order by posts.ViewCount DESC;
