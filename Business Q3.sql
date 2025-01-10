----Business Request - 3: City-Level Repeat Passenger Trip Frequency Report---

WITH frequency_distribution AS (
    SELECT 
        city_id, 
        trip_count, 
        SUM(repeat_passenger_count) AS total_repeat_passenger,
        SUM(SUM(repeat_passenger_count)) OVER (PARTITION BY city_id) AS city_total_repeat_passenger
    FROM 
        trips_db.dim_repeat_trip_distribution
    WHERE 
        trip_count BETWEEN 2 AND 10 -- Filter for relevant trip counts
    GROUP BY 
        city_id, trip_count
)
SELECT 
    c.city_name,----------Calculate frequency distribution---
    ROUND(SUM(CASE WHEN trip_count = 2 THEN total_repeat_passenger ELSE 0 END) * 100.0 / MAX(city_total_repeat_passenger), 2) AS "2-Trips",
    ROUND(SUM(CASE WHEN trip_count = 3 THEN total_repeat_passenger ELSE 0 END) * 100.0 / MAX(city_total_repeat_passenger), 2) AS "3-Trips",
    ROUND(SUM(CASE WHEN trip_count = 4 THEN total_repeat_passenger ELSE 0 END) * 100.0 / MAX(city_total_repeat_passenger), 2) AS "4-Trips",
    ROUND(SUM(CASE WHEN trip_count = 5 THEN total_repeat_passenger ELSE 0 END) * 100.0 / MAX(city_total_repeat_passenger), 2) AS "5-Trips",
    ROUND(SUM(CASE WHEN trip_count = 6 THEN total_repeat_passenger ELSE 0 END) * 100.0 / MAX(city_total_repeat_passenger), 2) AS "6-Trips",
    ROUND(SUM(CASE WHEN trip_count = 7 THEN total_repeat_passenger ELSE 0 END) * 100.0 / MAX(city_total_repeat_passenger), 2) AS "7-Trips",
    ROUND(SUM(CASE WHEN trip_count = 8 THEN total_repeat_passenger ELSE 0 END) * 100.0 / MAX(city_total_repeat_passenger), 2) AS "8-Trips",
    ROUND(SUM(CASE WHEN trip_count = 9 THEN total_repeat_passenger ELSE 0 END) * 100.0 / MAX(city_total_repeat_passenger), 2) AS "9-Trips",
    ROUND(SUM(CASE WHEN trip_count = 10 THEN total_repeat_passenger ELSE 0 END) * 100.0 / MAX(city_total_repeat_passenger), 2) AS "10-Trips"
FROM 
    frequency_distribution fd
JOIN 
    trips_db.dim_city c ON fd.city_id = c.city_id
GROUP BY 
    c.city_name
ORDER BY 
    c.city_name;

