--the activity table shows the app-installed and the app purchase activities for spotify along with country details

CREATE table activity
(
user_id varchar(20),
event_name varchar(20),
event_date date,
country varchar(20)
);
delete from activity;
insert into activity values (1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

select * from activity;

--1. daily active users : active users according to date
select event_date, count(distinct user_id) as active_users
from activity
group by event_date

-- 2. Find total active users each week
/*select *, datediff(week, 2022-01-01, 2022-01-04) as date_week from activity*/
select datepart(week,event_date), count(distinct user_id) as active_users
from activity
group by datepart(week, event_date);

--3. datewise total number of users who made the purchase same day they installed the app
with cte as(
select user_id, event_date, count(distinct event_name) as no_of_events
from activity
group by user_id, event_date
having count(distinct event_name) = 2
)
select event_date, count(distinct user_id) as users
from cte 
group by event_date;

with cte1 as (
select user_id, event_date, 
case when count(distinct event_name) = 2 then user_id else null end as users_event
from activity
group by user_id, event_date
)
select event_date, count(users_event) from cte1 group by event_date;

--percentage of paid uses tagged as country percent_users

with cte_country as (
select case when country in ('USA', 'India') then country else 'others' end as new_country,
count(distinct user_id) as users_per_country
from activity
where event_name = 'app-purchase'
group by case when country in ('USA', 'India') then country else 'others' end),
total as (select sum(users_per_country) as total from cte_country)
select new_country, (users_per_country * 1.0* 100)/total 
from cte_country, total;

--5. among all users who installed the app on a given day and purchased it the very next day?
with prev_data as (select *,
lag(event_name,1) over(partition by user_id order by event_date) as prev_event_name,
lag(event_date,1) over(partition by user_id order by event_date) as prev_event_date
from activity)
select event_date, count(distinct user_id) as cnt_users
from prev_data
where event_name = 'app-purchase' and prev_event_name = 'app-installed' and datediff(day, prev_event_date,event_date) = 1
group by event_date