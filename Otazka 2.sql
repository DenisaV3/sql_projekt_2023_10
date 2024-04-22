
-- Ot.2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT 
	measured_year,
	round(avg(avg_payroll_value)) AS avg_wages,
	price_category_name,
	avg_price_value,
	avg_category_price_value,
	price_unit,
	round(avg(avg_payroll_value)/avg_price_value) AS can_buy
FROM t_denisa_vanatkova_project_SQL_primary_final
WHERE measured_year IN (2006,2018) AND price_category_name IN ('Mléko polotučné pasterované','Chléb konzumní kmínový') 
GROUP BY measured_year, price_category_name, avg_price_value, avg_category_price_value, price_unit;