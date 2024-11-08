--STEP 2 DDL DML

SET SERVEROUTPUT ON;
 DECLARE
    table_exists NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*)
    INTO table_exists
    FROM user_tables
    WHERE table_name = 'INFLUENCERS';
    
    -- If the table exists, drop it
    IF table_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE INFLUENCERS CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table INFLUENCERS dropped successfully.');
    END IF;

    -- Create the INFLUENCERS table
    EXECUTE IMMEDIATE 'CREATE TABLE Influencers (
        Influencer_id INTEGER PRIMARY KEY,
        First_Name VARCHAR2(50),
        Last_Name VARCHAR2(50),
        Social_Media_Handle VARCHAR2(50)
    )';
    DBMS_OUTPUT.PUT_LINE('Table INFLUENCERS created successfully.');

    -- Insert records using EXECUTE IMMEDIATE for dynamic SQL
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (1, ''Emily'', ''Johnson'', ''@emilyj'')';
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (2, ''Michael'', ''Brown'', ''@michaelb'')';
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (3, ''Sophia'', ''Lee'', ''@sophial'')';
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (4, ''Liam'', ''Garcia'', ''@liamg'')';
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (5, ''Olivia'', ''Martinez'', ''@oliviam'')';
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (6, ''Noah'', ''Anderson'', ''@noaha'')';
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (7, ''Isabella'', ''Lopez'', ''@isabellal'')';
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (8, ''James'', ''Smith'', ''@jamess'')';
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (9, ''Mia'', ''Taylor'', ''@miat'')';
    EXECUTE IMMEDIATE 'INSERT INTO Influencers VALUES (10, ''Aiden'', ''White'', ''@aidenw'')';

    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');

    -- Commit the transaction
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction committed.');
END;
/



DECLARE
    table_exists NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*)
    INTO table_exists
    FROM user_tables
    WHERE table_name = 'USERS';
    
    -- If the table exists, drop it
    IF table_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE USERS CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table USERS dropped successfully.');
    END IF;

    -- Create the USERS table
    EXECUTE IMMEDIATE 'CREATE TABLE Users (
        User_id INTEGER PRIMARY KEY,
        First_Name VARCHAR2(50),
        Last_Name VARCHAR2(50),
        Email VARCHAR2(50),
        Location VARCHAR2(50) 
    )';
    DBMS_OUTPUT.PUT_LINE('Table USERS created successfully.');

    -- Insert records using EXECUTE IMMEDIATE for dynamic SQL
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (1, ''Jane'', ''Smith'', ''jane.smith@example.com'', ''North America'')';
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (2, ''John'', ''Williams'', ''john.williams@example.com'', ''Europe'')';
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (3, ''Emma'', ''Taylor'', ''emma.taylor@example.com'', ''Asia'')';
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (4, ''Michael'', ''Brown'', ''michael.brown@example.com'', ''South America'')';
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (5, ''Sophia'', ''Jones'', ''sophia.jones@example.com'', ''Australia'')';
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (6, ''Liam'', ''Garcia'', ''liam.garcia@example.com'', ''North America'')';
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (7, ''Olivia'', ''Martinez'', ''olivia.martinez@example.com'', ''Europe'')';
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (8, ''Noah'', ''Anderson'', ''noah.anderson@example.com'', ''Asia'')';
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (9, ''Isabella'', ''Lee'', ''isabella.lee@example.com'', ''Africa'')';
    EXECUTE IMMEDIATE 'INSERT INTO Users (User_id, First_Name, Last_Name, Email, Location) 
                       VALUES (10, ''Ethan'', ''Harris'', ''ethan.harris@example.com'', ''Australia'')';
                       
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
    
    -- Commit the transaction
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction committed.');
END;
/

DECLARE
    table_exists NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*)
    INTO table_exists
    FROM user_tables
    WHERE table_name = 'PRODUCTS';
    
    -- If the table exists, drop it
    IF table_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE PRODUCTS CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table PRODUCTS dropped successfully.');
    END IF;

    -- Create the PRODUCTS table
    EXECUTE IMMEDIATE 'CREATE TABLE Products (
        Product_id INTEGER PRIMARY KEY,
        Product_Name VARCHAR2(50),
        Price INTEGER,
        Quantity_in_hand INTEGER,
        Influencer_id INTEGER,
        FOREIGN KEY (Influencer_id) REFERENCES Influencers(Influencer_id)
    )';
    DBMS_OUTPUT.PUT_LINE('Table PRODUCTS created successfully.');

    -- Insert records using EXECUTE IMMEDIATE for dynamic SQL
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (1, ''Product A'', 100, 50, 1)';
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (2, ''Product B'', 200, 20, 2)';
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (3, ''Product C'', 300, 5, 1)';
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (4, ''Product D'', 150, 30, 2)';
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (5, ''Product E'', 250, 10, 1)';
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (6, ''Product F'', 180, 40, 2)';
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (7, ''Product G'', 350, 15, 1)';
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (8, ''Product H'', 220, 25, 2)';
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (9, ''Product I'', 400, 35, 1)';
    EXECUTE IMMEDIATE 'INSERT INTO Products (Product_id, Product_Name, Price, Quantity_in_hand, Influencer_id) 
                       VALUES (10, ''Product J'', 275, 12, 2)';
                       
    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');
    
    -- Commit the transaction
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction committed.');
END;
/
DECLARE
    table_exists NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*)
    INTO table_exists
    FROM user_tables
    WHERE table_name = 'ORDERS';
    
    -- If the table exists, drop it
    IF table_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ORDERS CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table ORDERS dropped successfully.');
    END IF;

    -- Create the ORDERS table
    EXECUTE IMMEDIATE 'CREATE TABLE Orders (
        Order_id INTEGER PRIMARY KEY,
        User_id INTEGER,
        order_date TIMESTAMP DEFAULT SYSTIMESTAMP,
        Total_price INTEGER,
        Order_Status VARCHAR2(50),
        FOREIGN KEY (User_id) REFERENCES Users(User_id)
    )';
    DBMS_OUTPUT.PUT_LINE('Table ORDERS created successfully.');

    -- Insert records using EXECUTE IMMEDIATE for dynamic SQL
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (1, 1, SYSTIMESTAMP - INTERVAL ''5'' DAY, 300, ''Pending'')';
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (2, 2, SYSTIMESTAMP - INTERVAL ''2'' DAY, 200, ''Shipped'')';
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (3, 3, SYSTIMESTAMP - INTERVAL ''10'' DAY, 100, ''Delivered'')';
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (4, 1, SYSTIMESTAMP - INTERVAL ''7'' DAY, 150, ''Processing'')';
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (5, 2, SYSTIMESTAMP - INTERVAL ''15'' DAY, 400, ''Cancelled'')';
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (6, 3, SYSTIMESTAMP - INTERVAL ''20'' DAY, 250, ''Delivered'')';
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (7, 1, SYSTIMESTAMP - INTERVAL ''1'' DAY, 180, ''Pending'')';
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (8, 2, SYSTIMESTAMP - INTERVAL ''3'' DAY, 275, ''Processing'')';
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (9, 3, SYSTIMESTAMP - INTERVAL ''8'' DAY, 320, ''Shipped'')';
    EXECUTE IMMEDIATE 'INSERT INTO Orders (Order_id, User_id, order_date, Total_price, Order_Status) 
                       VALUES (10, 1, SYSTIMESTAMP - INTERVAL ''12'' DAY, 220, ''Delivered'')';

    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');

    -- Commit the transaction
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction committed.');
END;
/


 DECLARE
    table_exists NUMBER;
BEGIN
    -- Check if the table exists
    SELECT COUNT(*)
    INTO table_exists
    FROM user_tables
    WHERE table_name = 'ORDER_DETAILS';
    
    -- If the table exists, drop it
    IF table_exists > 0 THEN
        EXECUTE IMMEDIATE 'DROP TABLE ORDER_DETAILS CASCADE CONSTRAINTS';
        DBMS_OUTPUT.PUT_LINE('Table ORDER_DETAILS dropped successfully.');
    END IF;

    -- Create the ORDER_DETAILS table
    EXECUTE IMMEDIATE 'CREATE TABLE Order_Details (
        Order_details_id INTEGER PRIMARY KEY,
        Order_id INTEGER,
        Product_id INTEGER,
        Quantity INTEGER,
        Price_per_unit INTEGER,
        FOREIGN KEY (Order_id) REFERENCES Orders(Order_id),
        FOREIGN KEY (Product_id) REFERENCES Products(Product_id)
    )';
    DBMS_OUTPUT.PUT_LINE('Table ORDER_DETAILS created successfully.');

    -- Insert records using EXECUTE IMMEDIATE for dynamic SQL
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (1, 1, 1, 2, 150)';
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (2, 2, 2, 1, 200)';
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (3, 3, 3, 1, 100)';
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (4, 1, 2, 3, 175)';
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (5, 2, 1, 2, 150)';
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (6, 3, 2, 4, 175)';
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (7, 4, 1, 1, 150)';
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (8, 5, 3, 5, 100)';
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (9, 6, 2, 2, 200)';
    EXECUTE IMMEDIATE 'INSERT INTO Order_Details (Order_details_id, Order_id, Product_id, Quantity, Price_per_unit) 
                       VALUES (10, 7, 1, 3, 150)';

    DBMS_OUTPUT.PUT_LINE('Data inserted successfully.');

    -- Commit the transaction
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transaction committed.');
END;
/
