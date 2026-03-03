-- leetcode problem number 570

select e.name from Employee e 
	join 
	(select managerID, count(managerID) as empCount from Employee 
	group by managerID having count(managerID)>=5) as m 
on m.managerID=e.id;    