
-- primarni tabulka vytvorena z dvou pomocnych mezitabulek


CREATE TABLE t_prim_cast_jedna AS 
WITH cze_payroll AS (
    SELECT 
        cp.industry_branch_code,
        cpib.name AS industry_branch_name,
        cp.payroll_year AS payroll_year,
        round(avg(cp.value)) AS avg_payroll_value
    FROM czechia_payroll cp 
    JOIN czechia_payroll_industry_branch cpib ON cpib.code = cp.industry_branch_code 
    WHERE cp.value_type_code = 5958 AND cpib.code IS NOT NULL 
    GROUP BY industry_branch_code,name, payroll_year,industry_branch_name 
)
SELECT *
FROM cze_payroll;


CREATE TABLE t_prim_cast_dva AS 
   WITH cze_price AS (
    SELECT 
        cp.category_code,
        cp.value AS price_value,
        YEAR(cp.date_from) AS measured_year,
        cpc.name AS price_category_name,
        cpc.price_value AS category_price_value,
        cpc.price_unit
    FROM czechia_price cp 
    JOIN czechia_price_category cpc 
        ON cpc.code = cp.category_code 
)
SELECT 
   measured_year,
    category_code,
    price_category_name,
    round (AVG(price_value),2) AS avg_price_value,
    category_price_value AS avg_category_price_value,
    price_unit
FROM cze_price
GROUP BY 
    measured_year,
    category_code,
    price_category_name,
    price_unit,
    category_price_value;
   
--- konecna primarni tabulka

CREATE TABLE t_denisa_vanatkova_project_SQL_primary_final AS 
SELECT 
    cd.*,
    cj.avg_payroll_value,
    cj.industry_branch_code,
    cj.industry_branch_name
FROM t_prim_cast_dva cd
LEFT JOIN t_prim_cast_jedna cj
    ON cj.payroll_year = cd.measured_year 
    AND cj.payroll_year BETWEEN 2006 AND 2018;


 SELECT *
 FROM t_denisa_vanatkova_project_SQL_primary_final;
