CREATE TABLE city_population (
    state VARCHAR(50),
    city VARCHAR(50),
    population INT
);

-- Insert the data
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'ambala', 100);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'panipat', 200);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'gurgaon', 300);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'amritsar', 150);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'ludhiana', 400);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'jalandhar', 250);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'mumbai', 1000);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'pune', 600);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'nagpur', 300);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'bangalore', 900);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mysore', 400);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mangalore', 200);

/* derive max and min population of every state */
 with cte as (select *,
rank() over(partition by state order by cp.population desc) as rnk_population
from city_population cp), 
cte2 as (select state, city, population as max_population from cte where rnk_population=1),
cte3 as (select state, city, population as min_population from cte where rnk_population=3)
select m.state,max_population, n.min_population from cte2 m
full join
cte3 n 
on m.city = n.city
group by m.state
;

select * from city_population

with cte as(
select *,
max(population) over(partition by state) as max_population,
min(population) over(partition by state) as min_population
from city_population)
select state,
max(case when population = max_population then city else null end) as highest_populated_city,
min(case when population = min_population then city else null end) as lowest_populated_city
from cte
group by state;

with cte as (
select *,
Rank() over(partition by state order by population desc) as rn_desc,
Rank() over(partition by state order by population asc) as rn_asc
from city_population) 
select state,
max(case when rn_desc = 1 then population end) as Highest_populated_city,
min(case when rn_asc = 1 then population end) as Lowest_populated_city
from cte
group by state













































































































































































































































































from city_population


