
create table source_i(id int, name varchar(5))

create table target(id int, name varchar(5))

insert into source_i values(1,'A'),(2,'B'),(3,'C'),(4,'D')

insert into target values(1,'A'),(2,'B'),(4,'X'),(5,'F');

-- for output we want,
-- 1. records new/unique to source
-- 2. records new/unique to target
-- 3. records present in both source and target but values mismatched

-- null is not comparable. 
-- The COALESCE() function returns the first non-null value in a list.
--The COALESCE() function in SQL Server is a powerful tool designed to handle NULL values effectively.
--It evaluates a list of expressions in a specified order and returns the first non-null value encountered.

 select coalesce(s.id, t.id) as id, 
 --s.name, t.name,
 case when t.name is null then 'New to source'
 when s.name is null then 'New to target'
 when s.name != t.name then 'Mismatched'
 end as comments
 from source_i s
 full outer join 
 target t on s.id = t.id
 where s.name != t.name or s.name is null or t.name is null

