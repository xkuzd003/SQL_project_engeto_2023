

Čtvrtá otázka

SELECT *,
	CASE
		WHEN price_growth-payroll_percent > 10 THEN 1
		ELSE 0
	END AS diff
FROM (
SELECT
	t.payroll_year,
	t.price_average,
	t.salary_average,
	t2.payroll_year + 1 AS year_prev,
	round( ( t.price_average - t2.price_average ) / t2.price_average * 100, 2 ) AS price_growth,
	round( ( t.salary_average - t2.salary_average ) / t2.salary_average * 100, 2) AS payroll_percent
FROM
	t_darikuz_primary_final AS t
JOIN t_darikuz_primary_final AS t2
    ON
	t.payroll_year = t2.payroll_year + 1
GROUP BY
	payroll_year
ORDER BY
	payroll_year
)c
