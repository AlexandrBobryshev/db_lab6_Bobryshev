-- Функція, яка повертає всі замовлення, дорожче заданого значення.

DROP FUNCTION IF EXISTS get_orders_above_threshold(numeric);
CREATE OR REPLACE FUNCTION get_orders_above_threshold(threshold numeric)
	RETURNS TABLE (order_number int, total numeric)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
		SELECT order_items.order_number, round(sum(quantity * product_price) :: numeric, 2) as total
		FROM order_items
		JOIN items ON order_items.item_name = items.item_name
		GROUP BY order_items.order_number
		HAVING sum(quantity * product_price) > threshold;
END;
$$;

-- перевірка роботи функції
select * from get_orders_above_threshold(20);
