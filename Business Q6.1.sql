WITH fact_passenger_summary AS (
    SELECT 
        city_id,
        `Month Name` AS month_name,
        SUM(repeat_passengers) AS total_repeat_passengers,
        SUM(total_passengers) AS total_passengers,
        ROUND(SUM(repeat_passengers) * 100.0 / SUM(total_passengers), 2) AS monthly_repeat_passenger_rate
    FROM 
        fact_passenger_summary
    GROUP BY 
        city_id, `Month Name`
)
SELECT * FROM fact_passenger_summary;
