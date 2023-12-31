-- Тригер, який автоматично додає дату в таблицю orders при додаванні order_number;
CREATE OR REPLACE FUNCTION insert_date() RETURNS trigger
LANGUAGE 'plpgsql'
AS 
$$ 
BEGIN 
 	-- Оновлення поля order_date в orders на поточну дату для відповідного order_number
    UPDATE orders SET order_date = current_date  
    WHERE orders.order_number = NEW.order_number;  
    RETURN NULL; 
END; 
$$; 

DROP TRIGGER IF EXISTS order_insert_date ON orders;

-- Створення триггера, який викликає функцію insert_date після вставки нового запису в orders
CREATE TRIGGER order_insert_date  
AFTER INSERT ON orders 
FOR EACH ROW EXECUTE FUNCTION insert_date(); 

--перевірка роботи тригера
insert into orders (order_number) values (16500);
select * from orders;

delete from orders
where order_number = 16500;

select * from orders;
