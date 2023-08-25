

Třetí otázka

CREATE OR REPLACE VIEW v_third_q AS	
SELECT *
FROM (
SELECT
	product,
	payroll_year,
	price_average,
	LAG(price_average) OVER (PARTITION BY product ORDER BY payroll_year) AS previous_year_price
FROM t_darikuz_primary_final
GROUP BY 
	product,
	payroll_year
ORDER BY
	product,
	payroll_year
)tdp		
WHERE previous_year_price IS NOT NULL



SELECT *
FROM v_third_q

DROP VIEW v_third_q

SELECT
	product,
	ROUND((price_average - previous_year_price) /previous_year_price, 2) * 100 AS price_result	
FROM v_third_q
GROUP BY product
ORDER BY price_result
LIMIT 1;
