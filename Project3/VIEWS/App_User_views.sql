
CREATE OR REPLACE VIEW Current_Inventory_Status AS
SELECT Product_id, Product_Name, Quantity_in_hand,
       CASE WHEN Quantity_in_hand > 0 THEN 'In Stock'
            ELSE 'Out of Stock' END AS Stock_Status
FROM Products;


CREATE OR REPLACE VIEW Customer_Purchase_Behavior AS
SELECT u.User_id, u.First_Name || ' ' || u.Last_Name AS Customer_Name,
       COUNT(o.Order_id) AS Total_Orders,
       SUM(o.Total_price) AS Total_Spent
FROM Users u
JOIN Orders o ON u.User_id = u.User_id
GROUP BY u.User_id, u.First_Name, u.Last_Name;