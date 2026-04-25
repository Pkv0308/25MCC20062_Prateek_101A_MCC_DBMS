-- solution to question one
-- Write a SQL query to list all product names and the total quantity ordered for each.
-- Include products with no orders and show their quantity as 0.

select a.prod_name as Product, coalesce(sum(b.qty),0) as "Total Quantity" from Tbl_Products a
left join Tbl_Orders b on a.prod_id=b.prod_id group by a.prod_name;


-- solution to question two
-- Write a Postgres trigger to block an INSERT on Orders 
-- if the requested qty is greater than the stock_qty in the Products table.

create or replace function validateInsert()
returns trigger as $$
DECLARE
prod_stock INT;
BEGIN
select stock_qty into prod_stock from Tbl_Products where prod_id=new.prod_id;
if new.qty>prod_stock
then
Raise Exception 'Order Quantity exceeds Stock';
end if;

return new;
end;
$$ LANGUAGE PLPGSQL;


create or replace trigger orderCheck
before insert on Tbl_Orders
for each row
execute function validateInsert();



