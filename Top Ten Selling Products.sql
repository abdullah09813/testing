WITH LastMonthSales AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity
    FROM
        sales
    WHERE
        sale_date >= DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 month')
        AND sale_date < DATE_TRUNC('month', CURRENT_DATE)
    GROUP BY
        product_id
),
TopTenProducts AS (
    SELECT
        product_id,
        total_quantity,
        ROW_NUMBER() OVER (ORDER BY total_quantity DESC) AS rank
    FROM
        LastMonthSales
)
SELECT
    p.product_name,
    t.total_quantity
FROM
    TopTenProducts t
JOIN
    products p ON t.product_id = p.product_id
WHERE
    t.rank <= 10
ORDER BY
    t.total_quantity DESC;