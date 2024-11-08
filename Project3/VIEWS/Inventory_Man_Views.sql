CREATE OR REPLACE VIEW Current_Inventory_Status AS
SELECT Product_id, Product_Name, Quantity_in_hand,
       CASE WHEN Quantity_in_hand > 0 THEN 'In Stock'
            ELSE 'Out of Stock' END AS Stock_Status
FROM Products;
 
 
  
CREATE OR REPLACE VIEW Total_Sales_Region AS
SELECT u.Location AS Region, SUM(o.Total_price) AS Total_Sales
FROM Orders o
JOIN Users u ON o.User_id = u.User_id
GROUP BY u.Location;
 
 
 CREATE OR REPLACE VIEW Order_Fulfillment_Status AS
SELECT o.Order_id, u.First_Name || ' ' || u.Last_Name AS Customer_Name,
       o.order_date, o.Total_price, o.Order_Status
FROM Orders o
JOIN Users u ON o.User_id = u.User_id;