-- Request 1 --
SELECT trip_id, rider_name, fare
FROM trips WHERE city = 'Lagos';  

-- Request 2 --
SELECT rider_name, city, fare
FROM trips ORDER BY fare DESC LIMIT 5;

-- Request 3 --
SELECT DISTINCT city FROM trips;

-- Request 4 --
SELECT *
FROM trips WHERE payment_method = 'Card' AND fare > 5000;

-- Request 5 --
SELECT *
FROM trips WHERE distance_km BETWEEN 5 AND 10;  

-- Request 6 --
SELECT *
FROM trips WHERE rider_name LIKE 'A%'; 

-- Request 7 --
SELECT *
FROM trips WHERE payment_method IN ('Card', 'Wallet'); 

-- Request 8 --
SELECT *
FROM trips WHERE rating IS NULL;       
 
 -- Request 9 --
 SELECT *
FROM trips WHERE status = 'Completed' ORDER BY city ASC, fare DESC;

-- Request 10 --
SELECT COUNT(*) AS cancelled_trips
FROM trips WHERE status = 'Cancelled';  

-- Request 11 --
SELECT
    SUM(fare) AS total_revenue,
    AVG(fare) AS average_fare,
    MAX(fare) AS biggest_fare,
	MIN(fare) AS smallest_fare
FROM trips WHERE status = 'Completed';

-- Request 12 -- 
SELECT vehicle_type, COUNT(*) AS trip_count
FROM trips GROUP BY vehicle_type;

-- Request 13 --  
  SELECT city, SUM(fare) AS total_revenue
FROM trips WHERE status = 'Completed' GROUP BY city ORDER BY total_revenue DESC;

-- Request 14 --
SELECT city, AVG(rating) AS average_rating
FROM trips WHERE rating IS NOT NULL GROUP BY city HAVING AVG(rating) < 4.0; 

-- Request 15 --
SELECT
    trips.trip_id,
    trips.trip_date,
    trips.city,
    trips.vehicle_type,
    trips.driver_id,
    drivers.driver_name,
    drivers.home_city,
    trips.rider_name,
    trips.distance_km,
    trips.duration_min,
    trips.fare,
    trips.payment_method,
    trips.rating,
    trips.status
FROM trips JOIN drivers ON trips.driver_id = drivers.driver_id;  

-- Request 16 --
SELECT drivers.driver_name, COUNT(trips.trip_id) AS trip_count
FROM trips JOIN drivers ON trips.driver_id = drivers.driver_id GROUP BY drivers.driver_id, drivers.driver_name HAVING COUNT(trips.trip_id) > 6;   

