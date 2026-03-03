-- leetcode problem number 1661


select machine_id,
round(
sum (case when activity_type='end' then timestamp else -timestamp end) :: NUMERIC(20,3)/
sum (case when activity_type='end' then 1 end),3) as processing_time
from activity group by machine_id;