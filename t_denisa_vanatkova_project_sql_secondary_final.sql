
-- sekundarni tabulka

CREATE TABLE t_denisa_vanatkova_project_sql_secondary_final
	SELECT 
		e.YEAR AS review_year,
		c.country,
		e.population,
		e.GDP,
		e.gini			
FROM countries c 
JOIN economies e 
	ON c.country = e.country 
WHERE c.country = 'Czech Republic' AND e.`year` BETWEEN 2006 AND 2018;

	
	
SELECT * FROM t_denisa_vanatkova_project_sql_secondary_final;	

	
