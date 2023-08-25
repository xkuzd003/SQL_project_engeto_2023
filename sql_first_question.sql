

První otázka

CREATE OR REPLACE VIEW v_first_q AS 
SELECT
	industry,
	payroll_year,
	salary_average,
	LAG(salary_average) OVER (PARTITION BY industry ORDER BY payroll_year) AS previous_year_salary
FROM t_darikuz_primary_final
WHERE industry IS NOT NULL
GROUP BY 
	industry,
	payroll_year
ORDER BY
	industry,
	payroll_year


SELECT *
FROM v_first_q

DROP VIEW v_first_q
	
SELECT *	
FROM (
SELECT *,
		CASE
		WHEN previous_year_salary < salary_average THEN 'salary increased'
		ELSE 'salary decreased'
	END AS payroll_dif
FROM v_first_q
WHERE payroll_year BETWEEN 2007 AND 2018
)d
WHERE payroll_dif = 'salary decreased'
ORDER BY payroll_year




