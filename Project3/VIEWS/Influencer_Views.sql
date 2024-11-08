CREATE OR REPLACE VIEW Influencer_Sales_Performance AS
SELECT i.Influencer_id, i.First_Name || ' ' || i.Last_Name AS Influencer_Name,
       COUNT(od.Order_id) AS Total_Orders,
       SUM(od.Quantity * od.Price_per_unit) AS Total_Revenue
FROM Influencers i
JOIN Products p ON i.Influencer_id = p.Influencer_id
JOIN Order_Details od ON p.Product_id = od.Product_id
GROUP BY i.Influencer_id, i.First_Name, i.Last_Name;



CREATE OR REPLACE VIEW Current_Inventory_Status AS
SELECT Product_id, Product_Name, Quantity_in_hand,
       CASE WHEN Quantity_in_hand > 0 THEN 'In Stock'
            ELSE 'Out of Stock' END AS Stock_Status
FROM Products;