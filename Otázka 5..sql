-- Discord name: denisa_97272

-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

WITH price_payroll_data AS (
	SELECT 
		tdvp.measured_year,
		round(( avg(tdvp.avg_price_value)-avg(tdvp2.avg_price_value))/ avg(tdvp2.avg_price_value)*100,2) AS price_increase,
		round((avg(tdvp.avg_payroll_value)- avg(tdvp2.avg_payroll_value))/ avg(tdvp2.avg_payroll_value)*100,2) AS payroll_increase	
	FROM t_denisa_vanatkova_project_sql_primary_final tdvp
	JOIN t_denisa_vanatkova_project_sql_primary_final tdvp2
		ON tdvp.measured_year = tdvp2.measured_year + 1
	GROUP BY tdvp.measured_year),
gdp_data AS (
		SELECT 
			tdv1.review_year,
			tdv2.GDP,
			tdv1.GDP AS GDP_next_year,
			round((avg(tdv1.GDP)- avg(tdv2.GDP))/ avg(tdv2.GDP)*100,2) AS GDP_increase		
	FROM t_denisa_vanatkova_project_sql_secondary_final tdv1
	JOIN t_denisa_vanatkova_project_sql_secondary_final tdv2
		ON tdv1.review_year = tdv2.review_year + 1 
	GROUP BY tdv1.review_year )
SELECT 
	review_year,
	GDP_increase,
	payroll_increase,
	price_increase
FROM price_payroll_data
JOIN gdp_data
	ON price_payroll_data.measured_year = gdp_data.review_year;
	
	