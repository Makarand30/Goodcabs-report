---Business Request - 6: Repeat Passenger Rate Analysis---
---City-wide Repeat Passenger Rate---
SELECT
    city_id,
    SUM(repeat_passengers) AS total_repeat_passengers,
    SUM(total_passengers) AS total_passengers,
    ROUND(SUM(repeat_passengers) * 100.0 / SUM(total_passengers), 2) AS city_repeat_passenger_rate --- Calculating RPR by city in percentage
FROM
    fact_passenger_summary
GROUP BY
    city_id;

