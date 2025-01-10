---Business Request - 1: City-Level Fare and Trip Summary Report---
SELECT 
    city_id,
    COUNT(trip_id) AS total_trips,
    ROUND(AVG(fare_amount / `distance_travelled(km)`), 2) AS avg_fare_per_km,
    ROUND(AVG(fare_amount), 2) AS avg_fare_per_trip,
    ROUND((COUNT(trip_id) * 100.0 / SUM(COUNT(trip_id)) OVER ()), 2) AS percent_contribution_to_total_trips
FROM trips_db.fact_trips
GROUP BY city_id
;
