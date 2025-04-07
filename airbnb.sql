/* Find the room types that are searched most no of times. 
Output the room type alongside the number of searches for it.
If the filter for room types has more than one room type, 
consider each unique room type as a seperate row.
Sort the result based on the number of searches in descending order */

create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);

delete from airbnb_searches;
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')
;

select value as room_type, count(1) as no_of_searches
from airbnb_searches
cross apply string_split(filter_room_types, ',')
group by value
order by no_of_searches desc
