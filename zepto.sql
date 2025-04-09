create table numbers (n int);
insert into numbers values (1),(2),(3),(4),(5)
 insert into numbers values (9)

drop table numbers

-- if num = 1, o/p = 1, if num = 2, o/p = 2 2 and so on
--please note: solve this without recursive cte

--using recursive cte

with cte as
(select n, 1 as num_counter from numbers
union all
select n, num_counter +1 from cte
where num_counter +1 <= n)
select * from cte 
order by n

--without recursive cte

--approach 1
select n1.n, n2.n
from numbers n1
inner join
numbers n2 on n1.n >= n2.n
order by n1.n, n2.n


--approach 2
with cte as(
select ROW_NUMBER() over(order by (select null)) as n
from sys.all_columns
)
select n1.n, n2.n
from numbe
rs n1
inner join cte n2 on n1.n >= n2.n
where n2.n <= (select max(n) from numbers)
order by n1.n, n2.n