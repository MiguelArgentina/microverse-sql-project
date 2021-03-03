SELECT COUNT(*) AS Stops FROM stops

SELECT id FROM stops WHERE name LIKE 'Craiglockhart'

SELECT id, name FROM route INNER JOIN stops ON stop = id
 WHERE num = 4 AND company = 'LRT'
  ORDER BY pos

SELECT company, num, COUNT(*)
 FROM route WHERE stop=149 OR stop=53
  GROUP BY company, num
   HAVING COUNT(*) = 2

SELECT a.company, a.num, a.stop, b.stop
  FROM route AS a JOIN route AS b
  ON a.company = b.company AND a.num = b.num JOIN stops ON b.stop = stops.id
  WHERE a.stop = 53 AND stops.name = 'London Road'

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'London Road'

SELECT DISTINCT a.company, a.num
 FROM route a INNER JOIN route b
  ON a.company = b.company
  AND a.num = b.num
  WHERE a.stop = 115 AND b.stop = 137

SELECT DISTINCT a.company, a.num
 FROM route a INNER JOIN route b ON a.company = b.company AND a.num = b.num
 INNER JOIN stops stopa ON a.stop = stopa.id
 INNER JOIN stops stopb ON b.stop = stopb.id
WHERE stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross'

SELECT DISTINCT stopb.name, b.company, b.num
FROM route a INNER JOIN route b ON a.company = b.company AND a.num = b.num
  INNER JOIN stops AS stopa ON a.stop = stopa.id
  INNER JOIN stops AS stopb ON b.stop = stopb.id
   WHERE stopa.name = 'Craiglockhart' AND a.company = 'LRT'

SELECT a.num Num1, a.comp AS Comp1, a.transfer AS Transfer, b.num Num2, b.comp Comp2
FROM (SELECT DISTINCT a.num num, a.company comp, stopb.name transfer
  FROM route a INNER JOIN route AS b
    ON a.company = b.company AND a.num = b.num
  INNER JOIN stops AS stopa ON a.stop = stopa.id
  INNER JOIN stops AS stopb ON b.stop = stopb.id
  WHERE stopa.name = 'Craiglockhart') a
  INNER JOIN (SELECT DISTINCT a.num num, a.company comp, stopb.name transfer 
  FROM route a INNER JOIN route b ON a.company = b.company AND a.num = b.num
  INNER JOIN stops stopa ON a.stop = stopa.id
  INNER JOIN stops stopb ON b.stop = stopb.id
  WHERE stopa.name = 'Lochend') b ON a.transfer = b.transfer
  ORDER BY Num1, Transfer, Num2
