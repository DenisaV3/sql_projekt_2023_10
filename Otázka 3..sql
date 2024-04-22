-- Otázka 3.: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

WITH price_increase AS (
	SELECT 
		tdv.measured_year, 
		tdv.price_category_name,
		tdv.category_code,
		round((tdv.avg_price_value - tdv2.avg_price_value)/ tdv2.avg_price_value * 100, 2) AS diff_year_value
FROM t_denisa_vanatkova_project_sql_primary_final tdv
	JOIN t_denisa_vanatkova_project_sql_primary_final tdv2
		ON tdv.measured_year = tdv2.measured_year  + 1  
		AND tdv.price_category_name = tdv2.price_category_name 
	GROUP BY tdv.price_category_name, tdv.measured_year, tdv.category_code)
SELECT 
	*,	
	round(avg(diff_year_value),2) AS avg_percent_diff
FROM price_increase
GROUP BY price_category_name
ORDER BY avg_percent_diff
LIMIT 5;              


