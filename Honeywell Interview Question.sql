--During the development of a movie streaming service, a query is needed to return a list of movie 
--genre and the best movie in that genre based on the maximum avg review rating.
-- Result should have following columns : genre/ title / stars.
-- Record format is a repeating number of stars from 1 to 5, which is the avg rating of reviews rounded
-- to the nearest whole number
select * from movies
select * from reviews


select genre, title,   
case when ceiling(avg_rating) = 5 then '*****'
when ceiling(avg_rating) = 4 then '****'
when ceiling(avg_rating) = 3 then '***'
when ceiling(avg_rating) = 2 then '**'
end as stars from (
select m.genre, m.title, 
avg(r.rating) as avg_rating, 
ROW_NUMBER() over(partition by m.genre order by avg(r.rating) desc) as rn
from movies m
inner join reviews r
on m.id = r.movie_id
group by m.genre, m.title) n
where rn = 1


-- replicate function