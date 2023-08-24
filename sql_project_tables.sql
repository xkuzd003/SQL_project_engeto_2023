

---Primární tabulka

CREATE TABLE  t_darikuz_primary_final AS
SELECT *
FROM (
	SELECT avg(cp.value) AS price_average,cp.category_code,YEAR(cp.date_from) AS year_price
	FROM czechia_price AS cp
	GROUP BY cp.category_code,year_price
	)cpt
LEFT JOIN ( 
	SELECT avg(cpay.value) AS salary_average, cpay.value_type_code,cpay.payroll_year,cpay.industry_branch_code
	FROM czechia_payroll AS cpay
    WHERE cpay.value_type_code = 5958
    GROUP BY cpay.value_type_code,cpay.payroll_year,cpay.industry_branch_code
    )cpayt ON cpt.year_price = cpayt.payroll_year
LEFT JOIN (
	SELECT cpib.name AS industry,cpib.code AS code_of_industry
	FROM czechia_payroll_industry_branch AS cpib 
	)cpibt ON cpayt.industry_branch_code = cpibt.code_of_industry
LEFT JOIN ( 
	SELECT cpc.name AS product,cpc.code AS code_of_product
	FROM czechia_price_category AS cpc
	)cpct ON cpt.category_code = cpct.code_of_product
LEFT JOIN (
	SELECT e.GDP AS HDP,e.`year`
	FROM economies AS e 
	WHERE e.country = 'Czech republic'
	)et ON cpayt.payroll_year = et.`year`
	
SELECT *
FROM t_darikuz_primary_final;

DROP TABLE t_darikuz_primary_final;

	
---Sekundární tabulka

CREATE TABLE  t_darikuz_secondary_final AS
SELECT
	e.country,
	e.GDP,
	e.gini,
	e.population,
	e.`year`
FROM
	economies e
JOIN countries c
    ON
	e.country = c.country
WHERE
	c.continent = 'europe'
	AND e.year BETWEEN 2006 AND 2018
ORDER BY
	country,
	`year`;

SELECT *
FROM t_darikuz_secondary_final;

DROP TABLE t_darikuz_secondary_final;


























