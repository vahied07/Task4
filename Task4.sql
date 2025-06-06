/* Which are the top 5 best-selling products by quantity? */

SELECT 
    p.product_name,
    s.product_id,
    SUM(s.quantity) AS total_quantity_sold
FROM 
    sales_data_cleaned s
JOIN 
    products_cleaned p ON s.product_id = p.product_id
GROUP BY 
    s.product_id, p.product_name
ORDER BY 
    total_quantity_sold DESC
LIMIT 5;



/*Which store has the highest profit in the past year?*/

SELECT 
    st.store_id,
    st.store_name,
    st.city,
    st.region,
    SUM(s.total_amount) - st.operating_cost AS profit
FROM 
    sales_data_cleaned s
JOIN 
    stores_cleaned st ON s.store_id = st.store_id
WHERE 
    s.order_date >= CURDATE() - INTERVAL 12 MONTH
GROUP BY 
    st.store_id, st.store_name, st.city, st.region, st.operating_cost
ORDER BY 
    profit DESC
LIMIT 1;



-- Add index on customer_id in orders table
CREATE INDEX idx_customer_id ON customers_cleaned(customer_id);


-- Get customers who are older than 30

select customer_id, NAME from(select customer_id,first_name as Name,age from customers_cleaned) as sub where age >30;


-- get the east region customers 
 create view East_clients as select customer_id as ID ,first_name as Name from customers_cleaned where region= "East";
 select * from East_clients;