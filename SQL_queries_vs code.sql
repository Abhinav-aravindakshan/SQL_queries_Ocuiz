--Retrieve Users with Purchases in Last 30 Days
SELECT DISTINCT u.user_id, u.name, u.email
FROM Users u
JOIN transactions t ON u.user_id = t.user_id
WHERE t.transaction_date >= CURDATE() - INTERVAL 30 DAY;


--Identify Top 3 Products by Purchase Frequency
SELECT p.name, SUM(td.quantity) AS total_quantity_sold
FROM Products p
JOIN transaction_details td ON p.product_id = td.product_id
GROUP BY p.product_id
ORDER BY total_quantity_sold DESC
LIMIT 3;


--Calculate Revenue per Product Category
SELECT p.category, SUM(td.quantity * p.price) AS revenue
FROM Products p
JOIN transaction_details td ON p.product_id = td.product_id
GROUP BY p.category;


--Generate Transaction Summaries with Item Counts
SELECT t.transaction_id, COUNT(td.product_id) AS item_count
FROM transactions t
JOIN transaction_details td ON t.transaction_id = td.transaction_id
GROUP BY t.transaction_id;


--Find Users Exceeding $500 in Total Purchases
SELECT u.user_id, u.name, SUM(td.quantity * p.price) AS total_spent
FROM Users u
JOIN transactions t ON u.user_id = t.user_id
JOIN transaction_details td ON t.transaction_id = td.transaction_id
JOIN Products p ON td.product_id = p.product_id
GROUP BY u.user_id
HAVING total_spent > 500;

--Function to calculate remaining stock for a product
DELIMITER $$

CREATE FUNCTION GetRemainingStock(product_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE remaining_stock INT;
    SELECT stock - COALESCE(SUM(td.quantity), 0) INTO remaining_stock
    FROM Products p
    LEFT JOIN transaction_details td ON p.product_id = td.product_id
    WHERE p.product_id = product_id
    GROUP BY p.product_id;
    RETURN remaining_stock;
END $$

DELIMITER ;

--For Remaining Stock
SELECT GetRemainingStock(1); 


