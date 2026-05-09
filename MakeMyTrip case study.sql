select * from Booking_table
select * from user_table

--1. segment and user who booked flight in apr 2022
select u.segment, count(distinct u.user_id) as total_user_count,
count(distinct case when b.line_of_business = 'Flight' and b.booking_date between '2022-04-01' and '2022-04-30' then b.user_id end) as apr_flight
from booking_table b
right join user_table u
on b.user_id = u.user_id
group by segment;


--2. identify users whose first booking was hotel booking
with cte as (select user_id, Line_of_business,
row_number() over(partition by user_id order by booking_date) as rn
from booking_table)
select * from cte 
where Line_of_business = 'Hotel' and rn = 1;

--3. write a query to calculate the days between first and last booking of each user
with cte as (select user_id, 
min(booking_date) as first_booking_date, max(booking_date) as last_booking_date
from booking_table
group by user_id)
select *,
datediff(day, first_booking_date, last_booking_date) as days_diff
from cte


select user_id, min(booking_date), max(booking_date), datediff(day, min(booking_date), max(booking_date)) as day_diff
from booking_table
group by user_id


--4. Write a query to count number of flight and hotel bookings in each segment for year 2022?
select segment, Line_of_business, count(booking_id) as booking_count
from booking_table b
inner join user_table u
on b.user_id = u.user_id
where year(booking_date) = 2022
group by segment, Line_of_business