SELECT matchid, player FROM goal 
  WHERE teamid LIKE 'GER'

SELECT id,stadium,team1,team2
  FROM game WHERE id = 1012

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid) WHERE teamid LIKE 'GER'

SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid) WHERE player LIKE 'Mario%'

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam on teamid=id 
 WHERE gtime<=10

SELECT mdate, teamname
  FROM game JOIN eteam ON (team1=eteam.id)
 WHERE coach LIKE 'Fernando Santos'

SELECT player
  FROM game JOIN goal ON (id=matchid)
 WHERE stadium LIKE 'National Stadium, Warsaw'

SELECT DISTINCT player FROM game JOIN goal on game.id = goal.matchid
   WHERE 'GER' IN (game.team1, game.team2) AND goal.teamid != 'GER'

SELECT teamname, COUNT(*) AS goals
  FROM eteam JOIN goal ON id = teamid GROUP BY teamname

SELECT stadium, COUNT(*) AS goals
   FROM game JOIN goal ON id = matchid GROUP BY stadium

SELECT matchid, mdate, COUNT(teamid)
 FROM game JOIN goal on id = matchid WHERE 'POL' in (team1, team2)
  GROUP BY matchid, mdate

SELECT matchid, mdate, COUNT(teamid)
 FROM game JOIN goal on id = matchid WHERE 'GER' = goal.teamid
  GROUP BY matchid, mdate

SELECT mdate,
  team1, SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1,
  team2, SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game JOIN goal ON matchid = id
  GROUP BY mdate, matchid, team1, team2
  ORDER BY mdate, matchid, team1, team2
