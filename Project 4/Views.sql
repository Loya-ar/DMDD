CREATE OR REPLACE VIEW Current_Inventory_Status AS
SELECT 
    Product_id, 
    Product_Name, 
    Quantity_in_hand,
    CASE 
        WHEN Quantity_in_hand > 0 THEN 'In Stock'
        ELSE 'Out of Stock'
    END AS Stock_Status
FROM Products;

CREATE OR REPLACE VIEW Total_Sales_Region AS
SELECT 
    u.Location AS Region, 
    SUM(o.Total_price) AS Total_Sales
FROM Orders o
JOIN Users u ON o.User_id = u.User_id
GROUP BY u.Location;

CREATE OR REPLACE VIEW Influencer_Sales_Performance AS
SELECT 
    i.Influencer_id, 
    i.First_Name || ' ' || i.Last_Name AS Influencer_Name,
    COUNT(od.Order_id) AS Total_Orders,
    SUM(od.Quantity * od.Price_per_unit) AS Total_Revenue
FROM Influencers i
JOIN Products p ON i.Influencer_id = p.Influencer_id
JOIN Order_Details od ON p.Product_id = od.Product_id
GROUP BY i.Influencer_id, i.First_Name, i.Last_Name;

CREATE OR REPLACE VIEW Customer_Purchase_Behavior AS
SELECT 
    u.User_id, 
    u.First_Name || ' ' || u.Last_Name AS Customer_Name,
    COUNT(o.Order_id) AS Total_Orders,
    SUM(o.Total_price) AS Total_Spent
FROM Users u
JOIN Orders o ON u.User_id = o.User_id
GROUP BY u.User_id, u.First_Name, u.Last_Name;

CREATE OR REPLACE VIEW Order_Fulfillment_Status AS
SELECT 
    o.Order_id, 
    u.First_Name || ' ' || u.Last_Name AS Customer_Name,
    o.order_date, 
    o.Total_price, 
    o.Order_Status
FROM Orders o
JOIN Users u ON o.User_id = u.User_id;
