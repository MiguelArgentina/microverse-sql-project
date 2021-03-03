SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn

SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

SELECT name, DAY(whn), confirmed - LAG(confirmed, 1) 
  OVER (PARTITION BY name ORDER BY whn) AS new FROM covid
   WHERE name = 'Italy' AND MONTH(whn) = 3
    ORDER BY whn

SELECT name, DATE_FORMAT(whn, '%Y-%m-%d') AS Date, confirmed - LAG(confirmed, 1) 
  OVER (PARTITION BY name ORDER BY whn) AS new
    FROM covid WHERE name = 'Italy' AND WEEKDAY(whn) = 0
      ORDER BY whn

SELECT current.name, DATE_FORMAT(current.whn, '%Y-%m-%d') AS Date, current.confirmed - previous.confirmed AS new
  FROM covid AS current LEFT JOIN covid AS previous
    ON DATE_ADD(previous.whn, INTERVAL 1 WEEK) = current.whn AND current.name = previous.name
    WHERE current.name = 'Italy' AND WEEKDAY(current.whn) = 0
      ORDER BY current.whn

SELECT name, confirmed, RANK() OVER (ORDER BY confirmed DESC) AS rank1, deaths, RANK() OVER (ORDER BY deaths DESC) AS rank2
  FROM covid
    WHERE whn = '2020-04-20'
      ORDER BY confirmed DESC

SELECT world.name, ROUND(100000 * covid.confirmed / world.population) AS rate, RANK() OVER (ORDER BY covid.confirmed / world.population ASC) AS rank
  FROM covid JOIN world ON covid.name = world.name
    WHERE whn = '2020-04-20' AND population >= 10000000
      ORDER BY population DESC

SELECT Name, Date, AuxQuery AS peakNewCases
FROM (SELECT current.name AS Name, DATE_FORMAT(current.whn, '%Y-%m-%d') AS Date, current.confirmed - previous.confirmed AS AuxQuery,
    RANK() OVER (PARTITION BY name ORDER BY AuxQuery DESC) AS Rank
  FROM covid AS current
  LEFT JOIN covid AS previous
    ON DATE_ADD(previous.whn, INTERVAL 1 DAY) = current.whn AND current.name = previous.name
  WHERE current.confirmed - previous.confirmed >= 1000
  GROUP BY current.name, Date) AS secondary
  WHERE Rank = 1
  ORDER BY Date, peakNewCases
