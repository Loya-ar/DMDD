SET SERVEROUTPUT ON; 

-- Procedure to Clean Existing Objects
CREATE OR REPLACE PROCEDURE clean_objects(obj_name VARCHAR, obj_type_name VARCHAR)
IS
    obj_cnt NUMBER := 0;
BEGIN
    IF obj_type_name = 'TABLE' THEN
        DBMS_OUTPUT.PUT_LINE('Dropping table ' || obj_name);
        SELECT COUNT(*) INTO obj_cnt FROM user_tables WHERE table_name = UPPER(obj_name);
        IF obj_cnt > 0 THEN
            EXECUTE IMMEDIATE 'DROP TABLE ' || obj_name || ' CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Table ' || obj_name || ' dropped successfully');
        END IF;
    END IF;

    IF obj_type_name = 'SEQUENCE' THEN
        DBMS_OUTPUT.PUT_LINE('Dropping sequence ' || obj_name);
        SELECT COUNT(*) INTO obj_cnt FROM user_sequences WHERE sequence_name = UPPER(obj_name);
        IF obj_cnt > 0 THEN
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || obj_name;
            DBMS_OUTPUT.PUT_LINE('Sequence ' || obj_name || ' dropped successfully');
        END IF;
    END IF;
END;
/

-- Clean Existing Objects
-- Drop Sequences
EXECUTE clean_objects('USERS_SEQ', 'SEQUENCE');
EXECUTE clean_objects('INFLUENCERS_SEQ', 'SEQUENCE');
EXECUTE clean_objects('PRODUCTS_SEQ', 'SEQUENCE');
EXECUTE clean_objects('ORDERS_SEQ', 'SEQUENCE');
EXECUTE clean_objects('ORDER_DETAILS_SEQ', 'SEQUENCE');

-- Drop Tables
EXECUTE clean_objects('USERS', 'TABLE');
EXECUTE clean_objects('INFLUENCERS', 'TABLE');
EXECUTE clean_objects('PRODUCTS', 'TABLE');
EXECUTE clean_objects('ORDERS', 'TABLE');
EXECUTE clean_objects('ORDER_DETAILS', 'TABLE');

-- Create Sequences
CREATE SEQUENCE USERS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE INFLUENCERS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE PRODUCTS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE ORDERS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE ORDER_DETAILS_SEQ START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- Create Tables

-- Users Table
CREATE TABLE USERS (
    User_id NUMBER(8) DEFAULT USERS_SEQ.NEXTVAL PRIMARY KEY,
    First_Name VARCHAR2(50) NOT NULL,
    Last_Name VARCHAR2(50) NOT NULL,
    Email VARCHAR2(50) NOT NULL UNIQUE,
    Location VARCHAR2(50) NOT NULL
);

-- Influencers Table
CREATE TABLE INFLUENCERS (
    Influencer_id NUMBER(8) DEFAULT INFLUENCERS_SEQ.NEXTVAL PRIMARY KEY,
    First_Name VARCHAR2(50) NOT NULL,
    Last_Name VARCHAR2(50) NOT NULL,
    Social_Media_Handle VARCHAR2(50) NOT NULL UNIQUE
);

-- Products Table
CREATE TABLE PRODUCTS (
    Product_id NUMBER(8) DEFAULT PRODUCTS_SEQ.NEXTVAL PRIMARY KEY,
    Product_Name VARCHAR2(50) NOT NULL,
    Price NUMBER(10, 2) NOT NULL,
    Quantity_in_hand NUMBER(8) NOT NULL,
    Influencer_id NUMBER(8) NOT NULL,
    CONSTRAINT FK_PRODUCTS_INFLUENCERS FOREIGN KEY (Influencer_id)
        REFERENCES INFLUENCERS (Influencer_id) ON DELETE CASCADE
);

-- Orders Table
CREATE TABLE ORDERS (
    Order_id NUMBER(8) DEFAULT ORDERS_SEQ.NEXTVAL PRIMARY KEY,
    User_id NUMBER(8) NOT NULL,
    Order_Date TIMESTAMP DEFAULT SYSTIMESTAMP,
    Total_Price NUMBER(10, 2) NOT NULL,
    Order_Status VARCHAR2(50) NOT NULL,
    CONSTRAINT FK_ORDERS_USERS FOREIGN KEY (User_id)
        REFERENCES USERS (User_id) ON DELETE CASCADE
);

-- Order Details Table
CREATE TABLE ORDER_DETAILS (
    Order_details_id NUMBER(8) DEFAULT ORDER_DETAILS_SEQ.NEXTVAL PRIMARY KEY,
    Order_id NUMBER(8) NOT NULL,
    Product_id NUMBER(8) NOT NULL,
    Quantity NUMBER(8) NOT NULL,
    Price_Per_Unit NUMBER(10, 2) NOT NULL,
    CONSTRAINT FK_ORDER_DETAILS_ORDERS FOREIGN KEY (Order_id)
        REFERENCES ORDERS (Order_id) ON DELETE CASCADE,
    CONSTRAINT FK_ORDER_DETAILS_PRODUCTS FOREIGN KEY (Product_id)
        REFERENCES PRODUCTS (Product_id) ON DELETE CASCADE
);

-- Insert Sample Data

-- Users Data
INSERT INTO USERS (First_Name, Last_Name, Email, Location)
VALUES ('John', 'Doe', 'john.doe@example.com', 'North America');
INSERT INTO USERS (First_Name, Last_Name, Email, Location)
VALUES ('Jane', 'Smith', 'jane.smith@example.com', 'Europe');
INSERT INTO USERS (First_Name, Last_Name, Email, Location)
VALUES ('Alice', 'Brown', 'alice.brown@example.com', 'Asia');
INSERT INTO USERS (First_Name, Last_Name, Email, Location)
VALUES ('Bob', 'Williams', 'bob.williams@example.com', 'Africa');
INSERT INTO USERS (First_Name, Last_Name, Email, Location)
VALUES ('Charlie', 'Johnson', 'charlie.johnson@example.com', 'South America');

-- Influencers Data
INSERT INTO INFLUENCERS (First_Name, Last_Name, Social_Media_Handle)
VALUES ('Emily', 'Johnson', '@emilyj');
INSERT INTO INFLUENCERS (First_Name, Last_Name, Social_Media_Handle)
VALUES ('Michael', 'Brown', '@michaelb');
INSERT INTO INFLUENCERS (First_Name, Last_Name, Social_Media_Handle)
VALUES ('Sarah', 'Williams', '@sarahw');
INSERT INTO INFLUENCERS (First_Name, Last_Name, Social_Media_Handle)
VALUES ('Daniel', 'Smith', '@daniels');
INSERT INTO INFLUENCERS (First_Name, Last_Name, Social_Media_Handle)
VALUES ('Olivia', 'Davis', '@oliviad');

-- Products Data
INSERT INTO PRODUCTS (Product_Name, Price, Quantity_in_hand, Influencer_id)
VALUES ('Product A', 100, 50, 1);
INSERT INTO PRODUCTS (Product_Name, Price, Quantity_in_hand, Influencer_id)
VALUES ('Product B', 200, 20, 2);
INSERT INTO PRODUCTS (Product_Name, Price, Quantity_in_hand, Influencer_id)
VALUES ('Product C', 150, 15, 3);
INSERT INTO PRODUCTS (Product_Name, Price, Quantity_in_hand, Influencer_id)
VALUES ('Product D', 300, 25, 4);
INSERT INTO PRODUCTS (Product_Name, Price, Quantity_in_hand, Influencer_id)
VALUES ('Product E', 120, 10, 5);

-- Orders Data
INSERT INTO ORDERS (User_id, Total_Price, Order_Status)
VALUES (1, 300, 'Pending');
INSERT INTO ORDERS (User_id, Total_Price, Order_Status)
VALUES (2, 400, 'Delivered');
INSERT INTO ORDERS (User_id, Total_Price, Order_Status)
VALUES (3, 250, 'Shipped');
INSERT INTO ORDERS (User_id, Total_Price, Order_Status)
VALUES (4, 500, 'Pending');
INSERT INTO ORDERS (User_id, Total_Price, Order_Status)
VALUES (5, 350, 'Cancelled');

-- Order Details Data
INSERT INTO ORDER_DETAILS (Order_id, Product_id, Quantity, Price_Per_Unit)
VALUES (1, 1, 2, 100);
INSERT INTO ORDER_DETAILS (Order_id, Product_id, Quantity, Price_Per_Unit)
VALUES (2, 2, 1, 200);
INSERT INTO ORDER_DETAILS (Order_id, Product_id, Quantity, Price_Per_Unit)
VALUES (3, 3, 3, 150);
INSERT INTO ORDER_DETAILS (Order_id, Product_id, Quantity, Price_Per_Unit)
VALUES (4, 4, 2, 300);
INSERT INTO ORDER_DETAILS (Order_id, Product_id, Quantity, Price_Per_Unit)
VALUES (5, 5, 4, 120);

-- Commit Transactions
COMMIT;
