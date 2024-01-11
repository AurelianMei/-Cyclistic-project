select * 
from [dbo].[202212-divvy-tripdata]
-- 181,806 rows 

-- check for types of rideable_bikes
select distinct rideable_type
from [dbo].[202212-divvy-tripdata]
-- 3 types: electric_bike, classic_bike, and docked_bike

-- check if started_at, ended_at col has NULL
SELECT *
FROM [dbo].[202212-divvy-tripdata]
WHERE 
    started_at IS NULL
    or ended_at IS NULL
-- started_at, ended_at col is clean

-- check if start_station_name has NULL
SELECT *
FROM [dbo].[202212-divvy-tripdata]
WHERE start_station_name IS NULL
/*
 29,283 rows (16%) containning NULL start_station_name. I have found a list of Divvy_Bicycle_Stations from data.cityofchicago.org so I attempted to patch this data
 however, the latitude and the longitude given for these stations are not enough to specify which station users come from
*/

-- check if end_station_name has NULL
SELECT *
FROM [dbo].[202212-divvy-tripdata]
WHERE end_station_name IS NULL
-- 31,158 rows

DELETE FROM [dbo].[202212-divvy-tripdata]
WHERE 
    start_station_name IS NULL
    OR end_station_name IS NULL
-- a total of 46,403 rows (25%) was affected

--recheck start_station_id and end_station_id
SELECT * 
FROM [dbo].[202212-divvy-tripdata]
WHERE start_station_id IS NULL OR end_station_id IS NULL
-- 0 row

-- check for member_casual column
SELECT *
FROM [dbo].[202212-divvy-tripdata]
WHERE member_casual IS NULL