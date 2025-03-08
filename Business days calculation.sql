/*write a sql query to find business days between create date and resolved date by
excluding weekends and public holidays for ticket resolution */

--2022-08-01 -> Monday, --2022-08-03 -> Wednesday
--2022-08-01 -> Monday, --2022-08-12 -> Friday
--2022-08-01 -> Monday, --2022-08-16 -> Tuesday

create table jira_tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
delete from jira_tickets;
insert into jira_tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');

create table holidays
(
holiday_date date
,reason varchar(100)
);
delete from holidays;
insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');
--weekends
select *,
datediff(day, create_date, resolved_date) as actual_days,
datediff(week, create_date, resolved_date) as week_diff,
datediff(day, create_date, resolved_date) - 2*datediff(week, create_date, resolved_date) as business_days
from jira_tickets
--no. of holidays
select ticket_id, create_date, resolved_date, count(holiday_date) as no_of_holidays
from jira_tickets
left join holidays on holiday_date between create_date and resolved_date
group by ticket_id, create_date, resolved_date


select *, 
datediff(day, create_date, resolved_date) as actual_days,
datediff(day, create_date, resolved_date) - 2*datediff(week, create_date, resolved_date) 
- no_of_holidays as business_days
from 
(select ticket_id, create_date, resolved_date, count(holiday_date) as no_of_holidays
from jira_tickets
left join holidays on holiday_date between create_date and resolved_date
group by ticket_id, create_date, resolved_date) A 

--assignment: what if the public holiday is on a weekend
select *, 
datediff(day, create_date, resolved_date) as actual_days,
datediff(day, create_date, resolved_date) - 2*datediff(week, create_date, resolved_date) 
- no_of_holidays as business_days
from (
select ticket_id, create_date, resolved_date, count(holiday_date) as no_of_holidays
from jira_tickets
left join holidays on holiday_date between create_date and resolved_date and
datename(weekday, holiday_date) not in ('Saturday', 'Sunday')
group by ticket_id, create_date, resolved_date
) A