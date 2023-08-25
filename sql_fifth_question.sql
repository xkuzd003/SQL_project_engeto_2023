

Pátá otázka

CREATE OR REPLACE
VIEW v_fifth_quest AS 
SELECT
	t.payroll_year,
	t.price_average,
	t.salary_average,
	t2.payroll_year + 1 AS year_prev,
	round( ( t.price_average - t2.price_average ) / t2.price_average * 100, 2 ) AS price_growth,
	round( ( t.salary_average - t2.salary_average ) / t2.salary_average * 100, 2) AS payroll_percent,
	t.hdp,
	round( ( avg(t.hdp) - avg(t2.hdp) ) / avg(t2.hdp) * 100, 2) AS hdp_percent
FROM
	t_darikuz_primary_final AS t
JOIN t_darikuz_primary_final AS t2
    ON
	t.payroll_year = t2.payroll_year + 1
GROUP BY
	payroll_year
ORDER BY
	payroll_year;

SELECT *
FROM v_fifth_quest

DROP VIEW v_fifth_quest

SELECT *,
	CASE
		WHEN hdp_percent > 5 THEN 'high_hdp_growth'
		WHEN hdp_percent > 0 THEN 'small_hdp_growth'
		WHEN hdp_percent < 0 THEN 'negative_hdp_growth'
	END AS hdp_growth
FROM v_fifth_quest;