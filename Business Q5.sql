---Business Request 5: Identify Month with Highest Revenue for Each City---
WITH monthly_revenue AS (
    SELECT 
        city_id, 
        Month AS month_name,  -- Use the Month column as is
        SUM(fare_amount) AS revenue
    FROM trips_db.fact_trips
    GROUP BY city_id, Month  -- Group by city_id and the Month column
),
city_total_revenue AS (
    SELECT 
        city_id, 
        SUM(revenue) AS total_revenue
    FROM monthly_revenue
    GROUP BY city_id
),
highest_month_revenue AS (
    SELECT 
        mr.city_id,
        mr.month_name,
        mr.revenue,
        ctr.total_revenue,
        ROUND((mr.revenue * 100.0 / ctr.total_revenue), 2) AS percentage_contribution ----Caluclate Percentage Contribution--
    FROM monthly_revenue mr
    JOIN city_total_revenue ctr
        ON mr.city_id = ctr.city_id
    WHERE mr.revenue = (
        SELECT MAX(revenue)
        FROM monthly_revenue
        WHERE city_id = mr.city_id
    )
)
SELECT 
    c.city_name,
    hmr.month_name AS highest_revenue_month,
    hmr.revenue,
    hmr.percentage_contribution
FROM highest_month_revenue hmr
JOIN trips_db.dim_city c
    ON hmr.city_id = c.city_id
ORDER BY c.city_name;
