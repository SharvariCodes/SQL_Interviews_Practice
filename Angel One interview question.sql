CREATE TABLE tickets (
    airline_number VARCHAR(10),
    origin VARCHAR(3),
    destination VARCHAR(3),
    oneway_round CHAR(1),
    ticket_count INT
);


INSERT INTO tickets (airline_number, origin, destination, oneway_round, ticket_count)
VALUES
    ('DEF456', 'BOM', 'DEL', 'O', 150),
    ('GHI789', 'DEL', 'BOM', 'R', 50),
    ('JKL012', 'BOM', 'DEL', 'R', 75),
    ('MNO345', 'DEL', 'NYC', 'O', 200),
    ('PQR678', 'NYC', 'DEL', 'O', 180),
    ('STU901', 'NYC', 'DEL', 'R', 60),
    ('ABC123', 'DEL', 'BOM', 'O', 100),
    ('VWX234', 'DEL', 'NYC', 'R', 90);

/*write a query to find busiest route along with total ticket count. 'O' --> Oneway trip
'R' --> Round trip
DEL --> BOM not same as BOM --> DEL*/
select * from tickets;

with cte as (select origin, destination, oneway_round, ticket_count 
from tickets
union all
select destination, origin, oneway_round, ticket_count 
from tickets
where oneway_round = 'R')

select top 1 origin,destination, sum(ticket_count) as tc
from cte
group by origin,destination
order by tc desc
