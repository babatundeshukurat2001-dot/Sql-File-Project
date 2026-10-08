USE quickride_plus;

-- Question 1 --
SELECT
    r.rider_name,
    d.driver_name,
    t.city,
    t.fare
FROM trips t
JOIN riders r  ON t.rider_id  = r.rider_id
JOIN drivers d ON t.driver_id = d.driver_id
WHERE t.status = 'Completed';

-- Question 2 --   
SELECT
    r.rider_name,
    d.driver_name,
    d.vehicle_type,
    t.fare
FROM trips t
JOIN riders r  ON t.rider_id  = r.rider_id
JOIN drivers d ON t.driver_id = d.driver_id
WHERE t.city = 'Lagos';

-- Question 3 --
SELECT
    r.rider_name,
    SUM(t.fare) AS total_spend
FROM trips t
JOIN riders r ON t.rider_id = r.rider_id
WHERE t.status = 'Completed'
GROUP BY r.rider_id, r.rider_name
ORDER BY total_spend DESC;

-- Question 4 --
SELECT
    d.driver_name,
    COUNT(t.trip_id) AS completed_trips,
    AVG(t.rating)    AS avg_rating
FROM drivers d
JOIN trips t ON d.driver_id = t.driver_id
WHERE t.status = 'Completed'
GROUP BY d.driver_id, d.driver_name;

-- Question 5 --
SELECT *
FROM trips
WHERE status = 'Completed'
  AND fare > (
        SELECT AVG(fare)
        FROM trips
        WHERE status = 'Completed'
      );
      
-- Question 6 --
SELECT
    driver_id,
    driver_name
FROM drivers
WHERE driver_id NOT IN (
    SELECT driver_id
    FROM trips
    WHERE status = 'Cancelled'
      AND driver_id IS NOT NULL
);

-- Question 7 --
SELECT
    r.rider_name,
    t.fare
FROM trips t
JOIN riders r ON t.rider_id = r.rider_id
WHERE t.fare = (
    SELECT MAX(fare)
    FROM trips
    WHERE status = 'Completed'
);

-- Question 8 --
SELECT
    r.rider_name,
    COUNT(t.trip_id) AS trip_count
FROM riders r
JOIN trips t ON r.rider_id = t.rider_id
GROUP BY r.rider_id, r.rider_name
HAVING COUNT(t.trip_id) > (
    SELECT COUNT(*)
    FROM trips t2
    JOIN riders r2 ON t2.rider_id = r2.rider_id
    WHERE r2.rider_name = 'Chioma Bello'
);

-- Question 9 --
SELECT DISTINCT
    r.rider_name
FROM riders r
JOIN trips t ON r.rider_id = t.rider_id
WHERE t.rating = 5;

-- Question 10 --
SELECT
    rider_name AS name,
    city       AS city,
    'Rider'    AS role
FROM riders

UNION

SELECT
    driver_name AS name,
    home_city   AS city,
    'Driver'    AS role
FROM drivers;

-- Question 11 --
SELECT city FROM trips

UNION

SELECT home_city FROM drivers;


-- Question 12 --
SELECT
    d.driver_name,
    SUM(t.fare) AS total_earned
FROM drivers d
JOIN trips t ON d.driver_id = t.driver_id
WHERE t.status = 'Completed'
GROUP BY d.driver_id, d.driver_name
ORDER BY total_earned DESC
LIMIT 1;
  


      

  
  
  



  