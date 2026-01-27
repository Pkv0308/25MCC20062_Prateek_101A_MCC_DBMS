-- leetcode problem number 1587


select name, sum(amount) as balance from
 Users right join Transactions 
 on Users.account = Transactions.account 
 group by name having balance>10000 