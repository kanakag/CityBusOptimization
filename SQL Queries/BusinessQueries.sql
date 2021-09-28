
-- 1.1 People travelling  on a route

select route_id, avg_onboard, total_onboard from (
select rides.*, schedules.route_id, schedules.dayOftheWeek, 
schedules.start_time, schedules.end_time, schedules.direction, 
avg(onboard) as avg_onboard, sum(onboard) as total_onboard,
sum(onboard)-sum(offboard) as difference from rides 
inner join schedules on rides.schedule_id=schedules.schedule_id group by schedules.route_id) 
as k ;

-- 1.2 number of riders on a particular day 

select dayOftheWeek, sum(onboard) from rides inner join schedules on rides.schedule_id=schedules.schedule_id group by schedules.dayOftheWeek; 

-- 1.3 number of riders on a particular route on a day 
select route_id,  schedules.dayOftheWeek, sum(onboard)from rides left join schedules on rides.schedule_id=schedules.schedule_id group by dayOftheWeek, route_id;


-- 1.4 number of riders by time slot
SELECT 
    (CASE
        WHEN
            HOUR(CAST(b.start_time AS TIME)) >= 6
                AND HOUR(CAST(b.start_time AS TIME)) < 11
        THEN
            'Morning'
        WHEN
            HOUR(CAST(b.start_time AS TIME)) >= 11
                AND HOUR(CAST(b.start_time AS TIME)) < 14
        THEN
            'Afternoon'
        WHEN
            HOUR(CAST(b.start_time AS TIME)) >= 14
                AND HOUR(CAST(b.start_time AS TIME)) < 17
        THEN
            'Evening'
        WHEN
            HOUR(CAST(b.start_time AS TIME)) >= 17
                AND HOUR(CAST(b.start_time AS TIME)) < 22
        THEN
            'Night'
        ELSE 'late night'
    END) AS time_slots,
    SUM(onboard),
    AVG(onboard)
FROM
    rides a
        LEFT JOIN
    schedules b ON a.schedule_id = b.schedule_id
GROUP BY time_slots;
 
 
 -- no of riders per route in time slot
 -- 1.5 number of riders by time slot on a route 
 
select time_slots , route_id , SUM(onboard),
    AVG(onboard) from
(SELECT 
    (CASE
        WHEN
            HOUR(CAST(b.start_time AS TIME)) >= 6
                AND HOUR(CAST(b.start_time AS TIME)) < 11
        THEN
            'Morning'
        WHEN
            HOUR(CAST(b.start_time AS TIME)) >= 11
                AND HOUR(CAST(b.start_time AS TIME)) < 14
        THEN
            'Afternoon'
        WHEN
            HOUR(CAST(b.start_time AS TIME)) >= 14
                AND HOUR(CAST(b.start_time AS TIME)) < 17
        THEN
            'Evening'
        WHEN
            HOUR(CAST(b.start_time AS TIME)) >= 17
                AND HOUR(CAST(b.start_time AS TIME)) < 22
        THEN
            'Night'
        ELSE 'late night'
    END) AS time_slots,
    route_id,
    onboard
FROM
    rides a
        LEFT JOIN
    schedules b ON a.schedule_id = b.schedule_id ) b 
GROUP BY time_slots, route_id; 




-- 2.1


select ro.route_short_name, count(distinct bus_id) as dis_bus 
from rides r  
left join schedules s on r.schedule_id = s.schedule_id  
left join route ro on s.route_id = ro.route_id 
group by ro.route_short_name 
order by dis_bus desc; 

---2.2

select case
	when s.dayOftheWeek = 0 then 'Sunday' 
	when s.dayOftheWeek = 1 then 'Monday' 
	when s.dayOftheWeek = 2 then 'Tuesday' 
	when s.dayOftheWeek = 3 then 'Wednesday' 
	when s.dayOftheWeek = 4 then 'Thursday' 
	when s.dayOftheWeek = 5 then 'Friday' 
	when s.dayOftheWeek = 6 then 'Saturday'  
	End as Day_Of_Week 
, count(distinct bus_id) 
from rides r  
left join schedules s on r.schedule_id = s.schedule_id  
group by s.dayOftheWeek 
order by count(distinct bus_id) desc; 
 
 
 -- 3.1
 
 select route_short_name,  case  
			when dayOftheWeek = 1 then 'Monday'
			when dayOftheWeek = 2 then 'Tuesday'
			when dayOftheWeek = 3 then 'Wednesday'
			when dayOftheWeek = 4 then 'Thursday'
			when dayOftheWeek = 5 then 'Friday'
			when dayOftheWeek = 6 then 'Saturday'
			when dayOftheWeek = 7 then 'Sunday'
       End as Day_Of_Week,start_time,end_time, avg(utilization) 
from ( select r.* , s.dayOftheWeek ,s.start_time, s.end_time ,c.*
, sum(r.onboard) over (partition by  r.bus_id, r.schedule_id order by r.ride_id) 
, sum(r.offboard) over (partition by  r.bus_id, r.schedule_id order by r.ride_id)  
, sum(r.onboard) over (partition by r.bus_id , r.schedule_id order by r.ride_id) 
-sum(r.offboard) over (partition by r.bus_id , r.schedule_id  order by r.ride_id)  
, b.bus_capacity 
, (sum(r.onboard) over (partition by r.bus_id , r.schedule_id  order by r.ride_id) 
-sum(r.offboard) over (partition by r.bus_id , r.schedule_id order by r.ride_id))/b.bus_capacity as utilization 
from rides r 
left join bus b on r.bus_id = b.bus_id
left join schedules s on s.schedule_id=r.schedule_id
left join route c on c.route_id=s.route_id) a 
group by 1 order by 2 desc; 



-- 3.2

select route_short_name, avg(utilization) 
from ( select r.* , s.dayOftheWeek ,s.start_time, s.end_time ,c.*
, sum(r.onboard) over (partition by r.bus_id , c.route_id  order by r.ride_id) 
, sum(r.offboard) over (partition by r.bus_id , c.route_id  order by r.ride_id)  
, sum(r.onboard) over (partition by r.bus_id , c.route_id  order by r.ride_id)-
  sum(r.offboard) over (partition by r.bus_id , c.route_id  order by r.ride_id)  , b.bus_capacity 
, (sum(r.onboard) over (partition by r.bus_id , c.route_id  order by r.ride_id)-
  sum(r.offboard) over (partition by r.bus_id , c.route_id  order by r.ride_id))/b.bus_capacity as utilization 
from rides r 
left join bus b on r.bus_id = b.bus_id 
left join schedules s on s.schedule_id=r.schedule_id
left join route c on c.route_id=s.route_id) a 
group by 1 order by 2 desc; 

 

 -- 3.3
 
 select route_short_name, (CASE 
    WHEN  hour(cast( a.start_time as time)) >=6 AND  hour(cast( a.start_time as time)) < 11 THEN 'Morning' 
    WHEN  hour(cast( a.start_time as time)) >=11 AND hour(cast( a.start_time as time)) < 14 THEN 'Afternoon' 
    WHEN  hour(cast( a.start_time as time)) >=14 AND hour(cast( a.start_time as time)) < 17 THEN 'Evening' 
    WHEN  hour(cast( a.start_time as time)) >=17 AND hour(cast( a.start_time as time)) < 22 THEN  'Night' 
    ELSE 'late night'                                   
    END) as time_slots, avg(utilization) as avg_utz 
from 
( select r.* , c.route_short_name
, sum(r.onboard) over (partition by r.bus_id , r.schedule_id order by r.ride_id) 
, sum(r.offboard) over (partition by r.bus_id , r.schedule_id order by r.ride_id)  
, sum(r.onboard) over (partition by r.bus_id , r.schedule_id order by r.ride_id)-
  sum(r.offboard) over (partition by r.bus_id , r.schedule_id  order by r.ride_id)  
, s.start_time 
, b.bus_capacity 
, (sum(r.onboard) over (partition by r.bus_id , r.schedule_id  order by r.ride_id)-
   sum(r.offboard) over (partition by r.bus_id , r.schedule_id order by r.ride_id))/b.bus_capacity as utilization 
from rides r 
left join bus b on r.bus_id = b.bus_id 
left join schedules s on r.schedule_id = s.schedule_id 
left join route c on c.route_id = s.route_id 
) a 
group by 1 order by 2 desc; 
 
