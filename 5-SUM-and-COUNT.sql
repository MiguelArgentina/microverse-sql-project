SELECT SUM(population) FROM world

SELECT DISTINCT continent from world

SELECT SUM(gdp) from world
  WHERE continent = 'Africa'

SELECT COUNT(name) from world
  WHERE area >= 1000000

SELECT SUM(population) from world
  WHERE name IN  ('Estonia', 'Latvia', 'Lithuania')

SELECT continent, count(name) from world
  GROUP BY continent

SELECT continent, count(name) from world WHERE population >= 10000000
  GROUP BY continent
 
 SELECT continent FROM world  GROUP BY continent
  HAVING SUM(population) > 100000000
