
-- 1

SELECT week_day_name, avg(reading)
FROM meter_readings JOIN date_dimension USING (date_id)
GROUP BY week_day_name;

-- 2

SELECT building_name, week_number, avg(reading)
FROM meter_readings JOIN date_dimension USING (date_id)
JOIN building_dimension USING (building_id)
WHERE week_number >= 50
GROUP BY building_name, week_number;

-- 3



-- 4

SELECT building_name, avg(reading)
FROM meter_readings JOIN building_dimension USING (building_id)
GROUP BY building_name;
ORDER BY avg(reading) DESC;

-- 5

SELECT building_name, avg(reading)
FROM meter_readings JOIN building_dimension USING (building_id)
JOIN date_dimension USING (date_id)
GROUP BY building_name, week_day_name;
ORDER BY avg(reading) DESC;

-- 6

SELECT building_name, day_period, avg(reading), avg_reading
FROM meter_readings JOIN building_dimension USING (building_id)
JOIN date_dimension USING (date_id)
GROUP BY building_name, day_period;
ORDER BY avg_reading DESC;

-- 7

SELECT building_name, day_period, hour_of_day, avg(reading)
FROM meter_readings JOIN building_dimension USING (building_id)
JOIN time_dimension USING (time_id)
GROUP BY ROLLUP (building_name, day_period, hour_of_day);
ORDER BY building_name, day_period, hour_of_day;

-- 8





