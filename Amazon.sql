--write a sql query to find total number of people inside the hospital
create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

--1.using case statements
with cte as (
select emp_id,
max(case when action = 'in' then time end) as intime,
max(case when action = 'out' then time end) as outtime
from hospital
group by emp_id
)
select * from cte
where intime > outtime or outtime is null


select emp_id,
max(case when action = 'in' then time end) as intime,
max(case when action = 'out' then time end) as outtime
from hospital
group by emp_id
having max(case when action = 'in' then time end) > max(case when action = 'out' then time end) or max(case when action = 'out' then time end) is null

--2. using joins

with intime as (
select emp_id, max(time) as latest_intime
from hospital
where action = 'in'
group by emp_id
),
outtime as (
select emp_id, max(time) as latest_outtime
from hospital
where action = 'out'
group by emp_id
)
select *
from intime i
left join outtime o on i.emp_id = o.emp_id
where latest_intime > latest_outtime or latest_outtime is null

--3. logic
with latest_time as (
select emp_id, max(time) as max_latest_time
from hospital
group by emp_id
),
latest_intime as (
select emp_id, max(time) as max_latest_intime
from hospital
where action = 'in'
group by emp_id)
select * from latest_time l
inner join latest_intime i
on l.emp_id = i.emp_id
and max_latest_time = max_latest_intime