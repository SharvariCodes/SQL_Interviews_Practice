--determine the user_ids and corresponding page_ids of the pages liked by their friend but not by
-- user itself yet.

select * from friends;
select * from likes;

-- solution1
--pages liked by users
with user_pages as (
select distinct f.user_id, l.page_id
from friends f
inner join likes l
on f.user_id = l.user_id
),
---pages liked by friends
friends_pages as (
select distinct f.user_id, f.friend_id, l.page_id
from friends f
inner join likes l
on f.friend_id = l.user_id) --primary cte

select distinct fp.user_id, fp.page_id
from friends_pages fp
left join user_pages up on fp.user_id = up.user_id and fp.page_id = up.page_id
where up.user_id is null
order by fp.user_id


--solution 2
---pages liked by friends
select distinct f.user_id, fp.page_id
from friends f 
inner join likes fp on f.friend_id = fp.user_id
left join likes up on f.user_id = up.user_id and fp.page_id = up.page_id
where up.page_id is null

--solution 3
select distinct f.user_id, fp.page_id
from friends f
inner join likes fp on f.friend_id = fp.user_id
where concat(f.user_id, fp.page_id) not in 
(
select distinct concat(f.user_id, fp.page_id) as concat_column
from friends f
inner join likes fp on f.user_id = fp.user_id
)
