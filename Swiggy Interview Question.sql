--This is one SQL question asked in Swiggy for a data analyst role. Here is the question: write a SQL query to find out supplier_id, product_id, and starting date of record_date for which stock quantity is less than 50 for two or more consecutive days.

--A table named supplier_inventory has columns supplier_id, product_id, stock_quantity, record_date.

with cte as (
select supplier_id, product_id, record_date,
LAG(record_date, 1, record_date) over(partition by supplier_id, product_id order by record_date) as prev_date,
datediff(day, LAG(record_date, 1, record_date) over(partition by supplier_id, product_id order by record_date), record_date) as daysdiff
from stock
where stock_quantity < 50),
cte2 as (
select * ,
case when daysdiff <= 1 then 0 else 1 end as group_flag,
sum(case when daysdiff <= 1 then 0 else 1 end) over(partition by supplier_id, product_id order by record_date) as group_id
from cte)
select supplier_id, product_id, count(*) as no_of_records, min(record_date) as first_date
from cte2
group by supplier_id, product_id, group_id
having count(*) >= 2