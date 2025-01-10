
-- Business Request 2 Monthly City-level Trips Target Performance Report--
SELECT 
    c.city_name, 
    ft.Month AS month_name, 
    COUNT(ft.trip_id) AS actual_trips, 
    mt.total_target_trips, 
    CASE 
        WHEN COUNT(ft.trip_id) > mt.total_target_trips THEN 'Above Target' 
        ELSE 'Below Target' 
    END AS performance_status, 
    ROUND(((COUNT(ft.trip_id) - mt.total_target_trips) * 100.0 / mt.total_target_trips), 2) AS percent_difference
FROM 
    trips_db.fact_trips ft
JOIN 
    trips_db.dim_city c ON ft.city_id = c.city_id
JOIN 
    targets_db.monthly_target_trips mt ON ft.city_id = mt.city_id AND ft.Month = mt.Month
GROUP BY 
    c.city_name, ft.Month, mt.total_target_trips
ORDER BY 
    c.city_name, ft.Month;
