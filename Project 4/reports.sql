--1. Top Customers by Number of Orders

SELECT 
    u.User_id, 
    u.First_Name || ' ' || u.Last_Name AS Customer_Name, 
    COUNT(DISTINCT o.Order_id) AS Order_Count
FROM Orders o
INNER JOIN Users u ON u.User_id = o.User_id
GROUP BY u.User_id, u.First_Name, u.Last_Name
ORDER BY Order_Count DESC
FETCH FIRST 10 ROWS ONLY;
/

--2. Top Regions by Total Sales

SELECT 
    u.Location AS Region, 
    SUM(o.Total_Price) AS Total_Sales
FROM Orders o
INNER JOIN Users u ON o.User_id = u.User_id
GROUP BY u.Location
ORDER BY Total_Sales DESC
FETCH FIRST 10 ROWS ONLY;
/

--3. Top Products by Quantity Sold

SELECT 
    p.Product_Name, 
    SUM(od.Quantity) AS Total_Quantity_Sold
FROM Order_Details od
INNER JOIN Products p ON od.Product_id = p.Product_id
GROUP BY p.Product_Name
ORDER BY Total_Quantity_Sold DESC
FETCH FIRST 5 ROWS ONLY;
/

--4. Influencers Driving the Most Sales

SELECT 
    i.First_Name || ' ' || i.Last_Name AS Influencer_Name, 
    SUM(od.Quantity * od.Price_Per_Unit) AS Total_Revenue
FROM Influencers i
INNER JOIN Products p ON i.Influencer_id = p.Influencer_id
INNER JOIN Order_Details od ON p.Product_id = od.Product_id
GROUP BY i.First_Name, i.Last_Name
ORDER BY Total_Revenue DESC
FETCH FIRST 5 ROWS ONLY;
/

--5. Pending Orders and Their Customers


SELECT 
    o.Order_id, 
    u.First_Name || ' ' || u.Last_Name AS Customer_Name, 
    o.Order_Status, 
    o.Order_Date, 
    o.Total_Price
FROM Orders o
INNER JOIN Users u ON o.User_id = u.User_id
WHERE o.Order_Status = 'Pending'
ORDER BY o.Order_Date ASC;
/

--6. Top 5 Regions with Most Orders


SELECT 
    u.Location AS Region, 
    COUNT(o.Order_id) AS Total_Orders
FROM Orders o
INNER JOIN Users u ON o.User_id = u.User_id
GROUP BY u.Location
ORDER BY Total_Orders DESC
FETCH FIRST 5 ROWS ONLY;
/

