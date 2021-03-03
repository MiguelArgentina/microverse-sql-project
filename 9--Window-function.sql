SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
  ORDER BY votes DESC

SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
  ORDER BY party

SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000021'
  ORDER BY party, yr

SELECT constituency, party, votes,
  RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) AS rank FROM get WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
  AND yr  = 2017 ORDER BY rank, constituency

SELECT constituency, party FROM ge AS x
  WHERE constituency BETWEEN 'S14000021' AND 'S14000026' AND yr  = 2017 AND votes = (SELECT MAX(votes)
  FROM ge AS y WHERE x.constituency = y.constituency AND yr = 2017)
   ORDER BY constituency, votes DESC

SELECT party, COUNT(*)
  FROM ge AS x WHERE constituency LIKE 'S%' AND yr  = 2017 AND votes = (SELECT MAX(votes)
  FROM ge AS y WHERE x.constituency = y.constituency AND yr = 2017)
   GROUP BY party
