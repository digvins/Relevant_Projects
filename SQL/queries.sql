-- Location of User 
SELECT * FROM post
WHERE location IN ('agra' ,'maharashtra','west bengal');


-- Most Followed Hashtag
SELECT 
	hashtag_name AS 'Hashtags', COUNT(hashtag_follow.hashtag_id) AS 'Total Follows' 
FROM hashtag_follow, hashtags 
WHERE hashtags.hashtag_id = hashtag_follow.hashtag_id
GROUP BY hashtag_follow.hashtag_id
ORDER BY COUNT(hashtag_follow.hashtag_id) DESC LIMIT 5;

-- Most Used Hashtags
SELECT 
	hashtag_name AS 'Trending Hashtags', 
    COUNT(post_tags.hashtag_id) AS 'Times Used'
FROM hashtags,post_tags
WHERE hashtags.hashtag_id = post_tags.hashtag_id
GROUP BY post_tags.hashtag_id
ORDER BY COUNT(post_tags.hashtag_id) DESC LIMIT 10;


-- Most Inactive User
SELECT user_id, username AS 'Most Inactive User'
FROM users
WHERE user_id NOT IN (SELECT user_id FROM post);

 
-- Most Likes Posts
SELECT post_likes.user_id, post_likes.post_id, COUNT(post_likes.post_id) 
FROM post_likes, post
WHERE post.post_id = post_likes.post_id 
GROUP BY post_likes.post_id
ORDER BY COUNT(post_likes.post_id) DESC ;

-- Average post per user
SELECT ROUND((COUNT(post_id) / COUNT(DISTINCT user_id) ),2) AS 'Average Post per User' 
FROM post;

-- no. of login by per user
SELECT user_id, email, username, login.login_id AS login_number
FROM users 
NATURAL JOIN login;


-- User who liked every single post (CHECK FOR BOT)
SELECT username, Count(*) AS num_likes 
FROM users 
INNER JOIN post_likes ON users.user_id = post_likes.user_id 
GROUP  BY post_likes.user_id 
HAVING num_likes = (SELECT Count(*) FROM   post); 

-- User Never Comment 
SELECT user_id, username AS 'User Never Comment'
FROM users
WHERE user_id NOT IN (SELECT user_id FROM comments);

-- User who commented on every post (CHECK FOR BOT)
SELECT username, Count(*) AS num_comment 
FROM users 
INNER JOIN comments ON users.user_id = comments.user_id 
GROUP  BY comments.user_id 
HAVING num_comment = (SELECT Count(*) FROM comments); 


-- User Not Followed by anyone
SELECT user_id, username AS 'User Not Followed by anyone'
FROM users
WHERE user_id NOT IN (SELECT followee_id FROM follows);

-- User Not Following Anyone
SELECT user_id, username AS 'User Not Following Anyone'
FROM users
WHERE user_id NOT IN (SELECT follower_id FROM follows);

-- Posted more than 5 times
SELECT user_id, COUNT(user_id) AS post_count FROM post
GROUP BY user_id
HAVING post_count > 5
ORDER BY COUNT(user_id) DESC;


-- Followers > 40
SELECT followee_id, COUNT(follower_id) AS follower_count FROM follows
GROUP BY followee_id
HAVING follower_count > 40
ORDER BY COUNT(follower_id) DESC;


-- Any specific word in comment
SELECT * FROM comments
WHERE comment_text REGEXP'good|beautiful';


-- Longest captions in post
SELECT user_id, caption, LENGTH(post.caption) AS caption_length FROM post
ORDER BY caption_length DESC LIMIT 5;