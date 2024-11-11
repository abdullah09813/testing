WITH SalesLastMonth AS (
    SELECT
        product_id,
        SUM(quantity) AS total_quantity
    FROM
        sales
    WHERE
        sale_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
        AND sale_date < DATE_TRUNC('month', CURRENT_DATE)
    GROUP BY
        product_id
),
TopFiveProducts AS (
    SELECT
        product_id,
        total_quantity,
        RANK() OVER (ORDER BY total_quantity DESC) AS rank
    FROM
        SalesLastMonth
)
SELECT
    product_id,
    total_quantity
FROM
    TopFiveProducts
WHERE
    rank <= 5;