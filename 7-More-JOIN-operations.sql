SELECT id, title
 FROM movie
 WHERE yr=1962

SELECT yr
 FROM movie
 WHERE title LIKE 'Citizen Kane'

SELECT id
 FROM actor
 WHERE name LIKE  'Glenn Close'

SELECT id
 FROM movie
 WHERE title LIKE 'Casablanca'

SELECT name from casting JOIN actor ON (actorid = id)
WHERE movieid = 
(SELECT id
 FROM movie
  WHERE title LIKE 'Casablanca')

SELECT name from casting JOIN actor ON (actorid = id)
WHERE movieid = 
(SELECT id
 FROM movie
 WHERE title LIKE 'Alien')

SELECT title from movie JOIN casting ON (movie.id = movieid) JOIN actor ON (actorid = actor.id)
 WHERE name LIKE 'Harrison Ford'

SELECT title FROM movie JOIN casting ON movie.id = casting.movieid
            JOIN actor ON actor.id = casting.actorid
            WHERE actor.name = 'Harrison Ford' 
              AND casting.ord != 1

SELECT title, name FROM movie JOIN casting ON (movie.id = movieid)
  JOIN actor ON actor.id = actorid
            WHERE ord = 1 AND yr = 1962

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
          WHERE name='Rock Hudson'
           GROUP BY yr HAVING COUNT(title) > 2

SELECT title, name
FROM movie JOIN casting ON movie.id = movieid AND ord = 1
            JOIN actor ON actor.id = actorid
    WHERE movie.id IN (SELECT casting.movieid FROM casting
    WHERE actorid IN (SELECT actor.id FROM actor WHERE name = 'Julie Andrews'))

SELECT name
FROM movie JOIN casting ON movie.id = movieid
            JOIN actor ON actor.id = actorid
              WHERE ord = 1 GROUP BY actor.id, name
   HAVING COUNT(title) >= 15 ORDER BY name

SELECT title, COUNT(actorid)
 FROM movie JOIN casting ON movie.id = movieid AND yr = 1978
  GROUP BY title ORDER BY COUNT(actorid) DESC, title

SELECT name FROM movie JOIN casting
             ON movie.id = movieid JOIN actor ON actor.id = actorid
  WHERE movie.id IN (SELECT movieid FROM casting
                       WHERE actorid IN 
                    (SELECT actor.id FROM actor
        WHERE name = 'Art Garfunkel'))  AND actor.name != 'Art Garfunkel'
