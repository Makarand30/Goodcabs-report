--Business Request - 6: Repeat Passenger Rate Analysis--
--1.	Monthly Repeat Passenger Rate----
WITH fact_passenger_summary AS (
    SELECT 
        city_id,
        `Month Name` AS month_name,
        SUM(repeat_passengers) AS total_repeat_passengers,
        SUM(total_passengers) AS total_passengers,
        ROUND(SUM(repeat_passengers) * 100.0 / SUM(total_passengers), 2) AS monthly_repeat_passenger_rate---- calculating RPR in percentage
    FROM 
        fact_passenger_summary
    GROUP BY 
        city_id, `Month Name`
)
SELECT * FROM fact_passenger_summary;
