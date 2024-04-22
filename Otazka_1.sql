
---- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?


SELECT 
    t.measured_year,
    t.industry_branch_name,
    t.avg_payroll_value,
    t2.avg_payroll_value AS previous_year_values,
    ROUND(t.avg_payroll_value - t2.avg_payroll_value) AS payroll_difference
FROM 
    t_denisa_vanatkova_project_SQL_primary_final t
JOIN 
    t_denisa_vanatkova_project_SQL_primary_final t2
    ON t.measured_year = t2.measured_year + 1 
    AND t.industry_branch_name = t2.industry_branch_name  
    AND t.price_category_name = t2.price_category_name  
GROUP BY 
    t.measured_year, t.industry_branch_name
HAVING 
    payroll_difference < 0;


 

