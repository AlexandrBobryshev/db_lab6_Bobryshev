-- Процедура, яка надає інформацію про назву найдорожчого товару в замовленні та про його ціну.
DROP PROCEDURE IF EXISTS get_item(int);

CREATE OR REPLACE PROCEDURE get_item(arg_order int)
LANGUAGE plpgsql
AS $$
DECLARE record_order_number items.item_name%TYPE;
DECLARE record_item_name items.item_name%TYPE;
DECLARE record_product_price items.item_name%TYPE;

BEGIN
	select order_number, item_name, product_price into record_order_number, record_item_name, record_product_price
	from items 
	join order_items using (item_name)
	where order_number = arg_order
	order by product_price desc;
	raise info 'Order_number: %, Item_name: %, Product_price: %',
	record_order_number, record_item_name, record_product_price;
END;
$$;

-- перевірка роботи процедури
call get_item(16116);