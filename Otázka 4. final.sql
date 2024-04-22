-- Discord name: denisa_97272

-- 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?


WITH payrollvsprice AS (
	SELECT 
		tdvp.measured_year,
		tdvp.category_code,
		tdvp.avg_price_value,
		round((avg(tdvp.avg_payroll_value)- avg(tdvp2.avg_payroll_value))/ avg(tdvp2.avg_payroll_value)*100,2) AS payroll_increase,
		round((avg(tdvp.avg_price_value)- avg(tdvp2.avg_price_value))/ avg(tdvp2.avg_price_value)*100,2) AS price_increase	
	FROM t_denisa_vanatkova_project_sql_primary_final tdvp
	JOIN t_denisa_vanatkova_project_sql_primary_final tdvp2
		ON tdvp.measured_year = tdvp2.measured_year + 1
		AND tdvp2.price_category_name = tdvp.price_category_name  
	GROUP BY measured_year ) 
SELECT 	
	measured_year,
	round(payroll_increase,2),
	price_increase,
	price_increase - payroll_increase AS increase_values
FROM payrollvsprice
ORDER BY increase_values DESC;