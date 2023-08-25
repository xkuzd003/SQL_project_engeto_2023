

Druhá otázka

SELECT DISTINCT product, category_code
FROM t_darikuz_primary_final


/*
 * chleb 111,301
 * mleko 114,201
 */


SELECT
	product,
	payroll_year,
	price_average,
	salary_average,
	round(salary_average/ price_average,2) AS average_pcs
FROM t_darikuz_primary_final
WHERE
	category_code IN (114201, 111301)
	AND payroll_year IN (2006, 2018)
GROUP BY
	payroll_year,
	product
ORDER BY
	product,
	payroll_year;