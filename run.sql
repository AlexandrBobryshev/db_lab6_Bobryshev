-- перевірка роботи функції
select * from get_orders_above_threshold(20);

-- перевірка роботи процедури
call get_item(16116);

-- перевірка роботи тригера
insert into orders (order_number) values (16500);
select * from orders;

delete from orders
where order_number = 16500;

select * from orders;