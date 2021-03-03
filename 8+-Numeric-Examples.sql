SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science'

SELECT institution, subject
  FROM nss
  WHERE (question='Q15' AND score >= 100)
 
SELECT institution,score
  FROM nss
 WHERE question='Q15'
   AND subject='(8) Computer Science'
   AND score < 50

SELECT subject, SUM(response)
  FROM nss WHERE question='Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject

SELECT subject, SUM(A_STRONGLY_AGREE / 100 * response)
  FROM nss WHERE question = 'Q22'
   AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design') GROUP BY subject

SELECT subject, ROUND(SUM(A_STRONGLY_AGREE / 100 * response) / 
  SUM(response) * 100)
    FROM nss WHERE question = 'Q22' AND subject IN ('(8) Computer Science', '(H) Creative Arts and Design')
    GROUP BY subject

SELECT institution, ROUND(SUM(score / 100 * response) / 
  SUM(response) * 100)
    FROM nss WHERE question = 'Q22' AND institution LIKE '%Manchester%'
    GROUP BY institution

SELECT institution, SUM(sample), (SELECT SUM(sample)
  FROM nss AS y WHERE x.institution = y.institution
    AND question = 'Q01'
    AND subject = '(8) Computer Science')
  FROM nss AS x
  WHERE question = 'Q01'
    AND institution LIKE '%Manchester%'
  GROUP BY institution
