Isaias Pomales
12.04.2014

Start running the application with the 'GameRecommendations.html' file.

Query for XML feed:
select titles that have a rating higher than 3 but the frequency played is less than 10.

Queries used to verify patterns:

Operating systems and the number of games that support them.
SELECT os, count(*) AS num
FROM supports
GROUP BY os;

Average rating of titles where the player plays a game of their preference.
SELECT d.title, AVG(d.rating) AS avgrating
FROM	(SELECT b.title, a.id
	FROM players a, games b
	WHERE a.preference = b.category) c, plays d
WHERE c.id = d.gamerid 	AND c.title = d.title
GROUP BY d.title
ORDER BY d.title asc;

Average rating of titles where player plays a game from the same country as them.
SELECT f.title, AVG(rating) AS avgrating
FROM plays f, (SELECT d.title, c.id
		FROM produced d, (SELECT a.id, b.company
				  FROM players a, developers b
				  WHERE a.location = b.country) c
		WHERE c.company = d.company) e
WHERE e.id = f.gamerid AND f.title = e.title
GROUPY BY f.title
ORDER BY f.title asc;

Average hours played when game is either role-playing or multiplayer online game.
SELECT c.title, AVG(c.hours) AS avghours
FROM plays c, (SELECT a.title
		FROM GAMES a
		WHERE a.category LIKE '%RPG%' OR a.category LIKE '%MMOG%') b
WHERE b.title = c.title
GROUP BY c.title
ORDERBY c.title asc;
