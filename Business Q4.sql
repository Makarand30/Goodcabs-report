WITH fact_passenger_summery AS (
    SELECT 
        city_id, 
        SUM(new_passengers) AS total_new_passengers -- Sum of new_passenger
    FROM trips_db.fact_passenger_summary
    GROUP BY city_id
),
ranked_cities AS (
    SELECT 
        city_id,
        total_new_passengers,
        RANK() OVER (ORDER BY total_new_passengers DESC) AS rank_high,
        RANK() OVER (ORDER BY total_new_passengers ASC) AS rank_low
    FROM fact_passenger_summery
)
SELECT 
    city_id,
    total_new_passengers,
    CASE 
        WHEN rank_high <= 3 THEN 'Top 3'
        WHEN rank_low <= 3 THEN 'Bottom 3'
    END AS city_category
FROM ranked_cities
WHERE rank_high <= 3 OR rank_low <= 3;
